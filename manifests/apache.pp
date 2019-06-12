# configure apache
# @api private
class pulp::apache {
  include apache
  include apache::mod::proxy
  include apache::mod::proxy_http
  include apache::mod::wsgi
  include apache::mod::ssl
  include apache::mod::xsendfile

  if $pulp::manage_httpd {
    if $pulp::enable_http or $pulp::enable_puppet {
      apache::vhost { 'pulp-http':
        priority            => '05',
        docroot             => '/usr/share/pulp/wsgi',
        port                => $pulp::http_port,
        servername          => $facts['fqdn'],
        serveraliases       => [$facts['hostname']],
        additional_includes => "${apache::confd_dir}/pulp-vhosts80/*.conf",
      }
    }

    $webservices_wsgi_directory = {
      'path'     => 'webservices.wsgi',
      'provider' => 'files',
    }

    if $pulp::ldap_url {
      include apache::mod::authnz_ldap
      $ldap_custom_fragment = {
        'custom_fragment' => template('pulp/ldap_custom_fragment.erb'),
        'require'         => 'unmanaged',
      }
    } else {
      $ldap_custom_fragment = {}
    }

    $base_directories = [
      merge($webservices_wsgi_directory, $ldap_custom_fragment),
      {
        'path'     => '/usr/share/pulp/wsgi',
        'provider' => 'directory',
      },
      {
        'path'     => '/pulp/static',
        'provider' => 'location',
      },
    ]

    if $pulp::ssl_username and !empty($pulp::ssl_username) {
      $directories = concat(
        $base_directories,
        {
          'path'            => '/pulp/api',
          'provider'        => 'location',
          'custom_fragment' => "SSLUsername ${pulp::ssl_username}",
        }
      )
    } else {
      $directories = $base_directories
    }

    $aliases = [
      {
        alias           => '/pulp/static',
        path            => '/var/lib/pulp/static',
        options         => ['Indexes'],
        custom_fragment => 'SSLRequireSSL',
      },
    ]

    apache::vhost { 'pulp-https':
      priority                   => '05',
      docroot                    => '/usr/share/pulp/wsgi',
      port                       => $pulp::https_port,
      servername                 => $facts['fqdn'],
      serveraliases              => [$facts['hostname']],
      keepalive                  => 'on',
      max_keepalive_requests     => $pulp::max_keep_alive,
      ssl                        => true,
      ssl_cert                   => $pulp::https_cert,
      ssl_key                    => $pulp::https_key,
      ssl_chain                  => $pulp::https_chain,
      ssl_ca                     => $pulp::ca_cert,
      ssl_certs_dir              => '',
      ssl_verify_client          => 'optional',
      ssl_protocol               => $pulp::ssl_protocol,
      ssl_options                => '+StdEnvVars +ExportCertData',
      ssl_verify_depth           => '3',
      wsgi_process_group         => 'pulp',
      wsgi_application_group     => 'pulp',
      wsgi_daemon_process        => join([
          'pulp',
          'user=apache',
          'group=apache',
          "processes=${pulp::wsgi_processes}",
          "maximum-requests=${pulp::wsgi_max_requests}",
          'display-name=%{GROUP}',
      ], ' '),
      wsgi_pass_authorization    => 'On',
      wsgi_import_script         => '/usr/share/pulp/wsgi/webservices.wsgi',
      wsgi_import_script_options => {
        'process-group'     => 'pulp',
        'application-group' => 'pulp',
      },
      wsgi_script_aliases        => merge(
        {'/pulp/api' => '/usr/share/pulp/wsgi/webservices.wsgi'},
        $pulp::additional_wsgi_scripts
      ),
      directories                => $directories,
      aliases                    => $aliases,
      options                    => ['SymLinksIfOwnerMatch'],
      add_default_charset        => 'UTF-8',
      # allow older yum clients to connect, see bz 647828
      custom_fragment            => 'SSLInsecureRenegotiation On',
    }

    # This file is installed by pulp-server but we have everything in the above vhost
    file {'/etc/httpd/conf.d/pulp.conf':
      ensure  => file,
      content => "# This file is managed by puppet, do not alter.\n",
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Service['httpd'],
    }
  } else {
    file {'/etc/httpd/conf.d/pulp.conf':
      ensure  => file,
      content => template('pulp/pulp.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Service['httpd'],
    }
  }

  if $pulp::manage_httpd or $pulp::manage_plugins_httpd {
    pulp::apache_plugin {'content' : vhosts80 => false}

    file { "${apache::confd_dir}/pulp-vhosts80/":
      ensure  => directory,
      owner   => 'apache',
      group   => 'apache',
      mode    => '0755',
      purge   => true,
      require => Package['pulp-server'],
    }

    if $pulp::enable_rpm {
      pulp::apache_plugin { 'rpm': }
    }

    if $pulp::enable_deb {
      pulp::apache_plugin { 'deb': vhosts80 => false }
    }

    if $pulp::enable_iso {
      pulp::apache_plugin { 'iso': }
    }

    if $pulp::enable_docker {
      include apache::mod::headers
      pulp::apache_plugin { 'docker': vhosts80 => false }
    }

    if $pulp::enable_puppet {
      pulp::apache_plugin { 'puppet': }
    }

    if $pulp::enable_python {
      pulp::apache_plugin { 'python': }
    }

    if $pulp::enable_ostree {
      pulp::apache_plugin { 'ostree': vhosts80 => false }
    }

    if $pulp::enable_parent_node {
      pulp::apache_plugin { 'nodes': vhosts80 => false }
    }
  }

  file {'/etc/httpd/conf.d/pulp_streamer.conf':
    ensure  => file,
    content => template('pulp/etc/httpd/conf.d/pulp_streamer.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['httpd'],
  }
}
