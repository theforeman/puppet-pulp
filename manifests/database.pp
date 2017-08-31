# Set up the pulp database
class pulp::database(
  Boolean $manage_db = $::pulp::manage_db,
  String $database = $::pulp::db_name,
  Optional[String] $username = $::pulp::db_username,
  Optional[String] $password = $::pulp::db_password,
  Integer[0] $migrate_timeout = $::pulp::migrate_db_timeout,
) {
  if $manage_db {
    include ::mongodb::server

    mongodb_database { $database:
      ensure => present,
      before => Exec['migrate_pulp_db'],
    }

    if $username {
      mongodb_user { $username:
        password => $password,
        database => $database,
        require  => Mongodb_database[$database],
        before   => Exec['migrate_pulp_db'],
      }
    }
  }

  exec { 'migrate_pulp_db':
    command   => 'pulp-manage-db && touch /var/lib/pulp/init.flag',
    path      => '/bin:/usr/bin',
    logoutput => 'on_failure',
    user      => 'apache',
    creates   => '/var/lib/pulp/init.flag',
    timeout   => $migrate_timeout,
  }
}
