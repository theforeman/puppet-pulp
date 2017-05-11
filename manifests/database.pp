# Set up the pulp database
class pulp::database {
  if $pulp::manage_db {
    include ::mongodb::server

    Service['mongodb'] -> Class['pulp::service']
    Service['mongodb'] -> Exec['migrate_pulp_db']
  }

  exec { 'migrate_pulp_db':
    command   => 'pulp-manage-db && touch /var/lib/pulp/init.flag',
    path      => '/bin:/usr/bin',
    logoutput => 'on_failure',
    user      => 'apache',
    creates   => '/var/lib/pulp/init.flag',
    timeout   => $pulp::migrate_db_timeout,
  }
}
