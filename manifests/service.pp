# Pulp Master Service
class pulp::service {
  if $::operatingsystemmajrelease == 7 {

    exec { 'pulp refresh system service':
      command     => '/bin/systemctl daemon-reload',
      before      => $servicelist,
      refreshonly => true,
    }
  }

  service { 'pulp_celerybeat':
    ensure     => running,
    require    => [Service[mongodb]],
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  service { 'pulp_workers':
    ensure     => running,
    require    => [Service[mongodb]],
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    status     => 'service pulp_workers status | grep "node reserved_resource_worker"',
  }

  service { 'pulp_resource_manager':
    ensure     => running,
    require    => [Service[mongodb]],
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    status     => 'service pulp_resource_manager status | grep "node resource_manager"',
  }

  if $pulp::enable_streamer {
    $servicelist =  Service['pulp_celerybeat', 'pulp_workers', 'pulp_resource_manager', 'pulp_streamer']
    service { 'pulp_streamer':
      ensure     => running,
      require    => [Service[mongodb]],
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
  } else {
     $servicelist = Service['pulp_celerybeat', 'pulp_workers', 'pulp_resource_manager']
  }
}
