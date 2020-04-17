class { 'pulp':
  manage_repo   => true,
  # https://github.com/theforeman/puppet-pulp/issues/138
  ssl_username  => '',
  enable_admin  => true,
  enable_puppet => true,
}

pulp_puppetrepo { 'SockPuppet':
  display_name    => 'Sock Puppet',
  description     => 'with kittens',
  note            => {'a' => 'b'},
  feed            => 'http://example.com/feed',
  validate        => true,
  feed_ca_cert    => '/etc/pki/pulp/ca.crt',
  verify_feed_ssl => true,
  feed_cert       => '/etc/pki/pulp/rsa_pub.key',
  feed_key        => '/etc/pki/pulp/rsa.key',
  proxy_host      => 'proxy.example.com',
  proxy_port      => 8080,
  # Proxy passwords are never idempotent since we can't retrieve the
  # password from the API. user requires a password
  #proxy_user      => 'puser',
  #proxy_pass      => 'ppassword',
  max_downloads   => 10,
  max_speed       => 10000,
  serve_http      => true,
  serve_https     => false,
}
