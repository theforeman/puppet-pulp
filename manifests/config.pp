# Pulp Master Configuration
class pulp::config {
  exec { 'selinux_pulp_manage_puppet':
    command => 'semanage boolean -m --on pulp_manage_puppet',
    path    => '/sbin:/usr/sbin:/bin:/usr/bin',
    onlyif  => 'getsebool pulp_manage_puppet | grep off',
  }

  file { '/var/lib/pulp/packages':
    ensure => directory,
    owner  => 'apache',
    group  => 'apache',
    mode   => '0755';
  }

  file { '/etc/pulp/server.conf':
    ensure  => file,
    content => template('pulp/server.conf.erb'),
    owner   => 'apache',
    group   => 'apache',
    mode    => '0600',
  }

  if $pulp::enable_http or $pulp::enable_puppet {
    apache::vhost { 'pulp-http':
      priority            => '05',
      docroot             => '/srv/pulp',
      port                => 80,
      servername          => [$::fqdn],
      serveraliases       => [$::hostname],
      additional_includes => '/etc/pulp/vhosts80/*.conf',
      add_default_charset => 'UTF-8',
    }
  }

  apache::vhost { 'pulp-https':
    priority            => '05',
    docroot             => '/srv/pulp',
    port                => 443,
    servername          => [$::fqdn],
    serveraliases       => [$::hostname],
    add_default_charset => 'UTF-8',
    ssl                 => true,
    ssl_cert            => $pulp::consumers_ca_cert,
    ssl_key             => $pulp::consumers_ca_key,
    ssl_ca              => $pulp::consumers_ca_cert,
    ssl_verify_client   => 'optional',
    ssl_protocol        => ' all -SSLv2',
    ssl_options         => '+StdEnvVars +ExportCertData',
    ssl_verify_depth    => '3',
    wsgi_process_group  => 'pulp',
    wsgi_application_group     => 'pulp',
    wsgi_daemon_process => 'pulp user=apache group=apache processes=1 threads=8 display-name=%{GROUP}',
    wsgi_pass_authorization    => 'On',
    wsgi_import_script  => '/srv/pulp/webservices.wsgi',
    wsgi_import_script_options => {
      'process-group'     => 'pulp',
      'application-group' => 'pulp'
    }
    ,
    wsgi_script_aliases => {
      '/pulp/api' => '/srv/pulp/webservices.wsgi'
    }
    ,
    directories         => [
      {
        'path'     => 'webservices.wsgi',
        'provider' => 'files',
      }
      ,
      {
        'path'     => '/srv/pulp',
        'provider' => 'directory',
      }
      ,
      {
        'path'     => '/pulp/static',
        'provider' => 'location',
      }
      ],
    aliases             => [{
        alias           => '/pulp/static',
        path            => '/var/lib/pulp/static',
        options         => ['Indexes'],
        custom_fragment => 'SSLRequireSSL'
      }
      ],
    options             => ['SymLinksIfOwnerMatch'],
    custom_fragment     => '# allow older yum clients to connect, see bz 647828
  SSLInsecureRenegotiation on'
  }

  if $pulp::enable_rpm {
    file { '/etc/httpd/conf.d/pulp_rpm.conf':
      ensure  => file,
      content => template('pulp/etc/httpd/conf.d/pulp_rpm.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }

    file { '/etc/pulp/repo_auth.conf':
      ensure  => file,
      content => template('pulp/repo_auth.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }

    file { '/etc/pulp/server/plugins.conf.d/yum_importer.json':
      ensure  => file,
      content => template('pulp/yum_importer.json'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }

    file { '/etc/pulp/server/plugins.conf.d/iso_importer.json':
      ensure  => file,
      content => template('pulp/iso_importer.json'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }

  if $pulp::enable_docker {
    file { '/etc/httpd/conf.d/pulp_docker.conf':
      ensure  => file,
      content => template('pulp/etc/httpd/conf.d/pulp_docker.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }

    file { '/etc/pulp/server/plugins.conf.d/docker_importer.json':
      ensure  => file,
      content => template('pulp/docker_importer.json'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }

  if $pulp::enable_puppet {
    file { '/etc/httpd/conf.d/pulp_puppet.conf':
      ensure  => file,
      content => template('pulp/etc/httpd/conf.d/pulp_puppet.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }

    file { '/etc/pulp/server/plugins.conf.d/puppet_importer.json':
      ensure  => file,
      content => template('pulp/puppet_importer.json'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }

  if $pulp::enable_parent_node {
    file { '/etc/httpd/conf.d/pulp_nodes.conf':
      ensure  => file,
      content => template('pulp/etc/httpd/conf.d/pulp_nodes.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }

  if $pulp::enable_child_node {
    file { '/etc/pulp/agent/conf.d/nodes.conf':
      ensure  => file,
      content => template('pulp/agent_nodes.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }

  if $pulp::enable_child_node or $pulp::enable_parent_node {
    file { '/etc/pulp/nodes.conf':
      ensure  => file,
      content => template('pulp/nodes.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }

  file { '/etc/pki/pulp/content/pulp-global-repo.ca':
    ensure => link,
    target => $pulp::consumers_ca_cert,
  }

  file { '/etc/default/pulp_workers':
    ensure  => file,
    content => template("pulp/${pulp::pulp_workers_template}"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  if $pulp::reset_cache {
    exec { 'reset_pulp_cache':
      command => 'rm -rf /var/lib/pulp/packages/*',
      path    => '/sbin:/bin:/usr/bin',
      require => File['/var/lib/pulp/packages'],
    }
  }

  if $pulp::consumers_crl {
    exec { 'setup-crl-symlink':
      command     => "/usr/bin/openssl x509 -in '${pulp::consumers_ca_cert}' -hash -noout | /usr/bin/xargs -I{} /bin/ln -sf '${pulp::consumers_crl}' '/etc/pki/pulp/content/{}.r0'",
      logoutput   => 'on_failure',
      refreshonly => true,
    }
  }
}
