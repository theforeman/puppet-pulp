#
# == Define: pulp::plugin
#
# Install and configure a Pulp plugin
#
define pulp::plugin (
  $package  = undef,
) {

  $real_package = $package ? {
      undef       => "pulp-${name}-plugins",
      default     => $package,
  }

  package { $real_package:
    ensure => installed,
  } ~>
  exec {'migrate_pulp_db':
    command     => 'pulp-manage-db && touch /var/lib/pulp/init.flag',
    path        => '/bin:/usr/bin',
    logoutput   => 'on_failure',
    user        => 'apache',
    require     => [Service[mongodb], Service[qpidd], File['/etc/pulp/server.conf']],
    refreshonly => true,
  }
}
