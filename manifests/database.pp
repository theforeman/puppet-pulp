# Set up the pulp database
# @api private
class pulp::database {
  if $pulp::manage_db {
    include mongodb::server

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
