# A pulp plugin apache config
#
# @param http_config The config for the HTTP vhost.
# @param global_config The config that's applied globally to Apache
define pulp::apache::plugin (
  Optional[String] $http_config = undef,
  Optional[String] $global_config = undef,
) {
  if $http_config {
    file { "/etc/pulp/vhosts80/${name}.conf":
      ensure  => file,
      content => $http_config,
      owner   => 'apache',
      group   => 'apache',
      mode    => '0600',
      require => Class['pulp::database'],
      notify  => Service['httpd'],
    }
  } else {
    file { "/etc/pulp/vhosts80/${name}.conf":
      ensure => absent,
      notify => Service['httpd'],
    }
  }

  if $global_config {
    file { "/etc/httpd/conf.d/pulp_${name}.conf":
      ensure  => file,
      content => $global_config,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Class['pulp::database'],
      notify  => Service['httpd'],
    }
  } else {
    file { "/etc/httpd/conf.d/pulp_${name}.conf":
      ensure => absent,
      notify => Service['httpd'],
    }
  }
}
