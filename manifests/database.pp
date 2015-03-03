# Set up the pulp database
class pulp::database {
  exec { 'migrate_pulp_db':
    command     => 'pulp-manage-db',
    path        => '/bin:/usr/bin',
    logoutput   => 'on_failure',
    user        => 'apache',
    refreshonly => true,
    require     => File['/etc/pulp/server.conf'],
  }

  if $pulp::reset_data {
    exec { 'reset_pulp_db':
      command => 'rm -f /var/lib/pulp/init.flag && service-wait httpd stop && service-wait mongod stop && rm -f /var/lib/mongodb/pulp_database*&& service-wait mongod start && rm -rf /var/lib/pulp/{distributions,published,repos}/*',
      path    => '/sbin:/usr/sbin:/bin:/usr/bin',
      before  => Exec['migrate_pulp_db'],
    }
  }

  Class['pulp::install'] ~> Exec['migrate_pulp_db'] ~> Class['pulp::service']
  Class['pulp::config'] ~> Exec['migrate_pulp_db'] ~> Class['pulp::service']
}
