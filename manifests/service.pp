# Pulp Master Service
# @api private
class pulp::service {
  exec { 'pulp refresh system service':
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true,
  } ->
  service { ['pulp_celerybeat', 'pulp_workers', 'pulp_resource_manager', 'pulp_streamer']:
    ensure => running,
    enable => true,
  }
}
