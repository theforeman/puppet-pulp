# Pulp migrate_db
class pulp::migrate_db {
  exec { 'migrate_pulp_db':
    command     => 'pulp-manage-db',
    path        => '/bin:/usr/bin',
    logoutput   => 'on_failure',
    user        => 'apache',
    refreshonly => true,
    require     => [Service[mongodb], Service[qpidd], File['/etc/pulp/server.conf']],
  }
}
