# Set up the pulp database
# @api private
class pulp::database {
  if $pulp::manage_db {
    class { 'mongodb::server':
      bind_ip => $pulp::mongodb_bind_ip,
      ipv6    => $pulp::mongodb_ipv6,
      ssl     => $pulp::mongodb_server_ssl,
      ssl_key => $pulp::mongodb_server_ssl_bundle,
      ssl_ca  => $pulp::mongodb_server_ssl_ca,
    }

    Service['mongodb'] -> Class['pulp::service']
    Service['mongodb'] -> Exec['migrate_pulp_db']
  }

  $pulp::services.each |$service| {
    transition { "stop ${service}":
      resource   => Service[$service],
      attributes => { ensure => 'stopped' },
      prior_to   => Exec['migrate_pulp_db'],
    }

    Exec['migrate_pulp_db'] ~> Service[$service]
  }

  exec { 'migrate_pulp_db':
    command   => 'pulp-manage-db',
    path      => '/bin:/usr/bin',
    logoutput => 'on_failure',
    user      => 'apache',
    timeout   => $pulp::migrate_db_timeout,
    unless    => 'pulp-manage-db --dry-run',
  }
}
