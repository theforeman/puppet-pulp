class { '::pulp':
  manage_repo  => true,
  # https://github.com/Katello/puppet-pulp/issues/138
  ssl_username => '',
  enable_admin => true,
}

pulp_isorepo { 'Hurry':
}

pulp_schedule { 'Hurry':
  schedule_time     => '2007-03-01T13:00:00Z/P1DT',
  enabled           => false,
  failure_threshold => 3,
}
