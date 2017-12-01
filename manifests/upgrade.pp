# An ugly hack that's required for upgrades. Pulp will refuse to upgrade the
# database if any service is running. This stops all services and removes the
# marker file that indicates the database is upgraded. It only does so when a
# package is installed or updated through puppet.
class pulp::upgrade {
  exec { 'stop services':
    command     => 'systemctl stop pulp_celerybeat pulp_workers pulp_resource_manager pulp_streamer && rm /var/lib/pulp/init.flag',
    path        => '/sbin:/usr/sbin:/bin:/usr/bin',
    subscribe   => Class['pulp::install'],
    before      => Class['pulp::database'],
    refreshonly => true,
  }
}
