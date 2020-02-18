# Pulp Master Service
# @api private
class pulp::service {
  exec { 'pulp refresh system service':
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true,
  } ->
  service { $pulp::services:
    ensure => running,
    enable => true,
  }
}
