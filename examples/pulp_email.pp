class { '::pulp':
  email_host    => 'localhost',
  email_port    => 25,
  email_from    => 'admin@example.com',
  email_enabled => true,
}
