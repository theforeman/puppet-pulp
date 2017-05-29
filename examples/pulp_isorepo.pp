class { '::pulp::repo::upstream': } ->
class { '::pulp':
  # https://github.com/Katello/puppet-pulp/issues/138
  ssl_username => '',
  enable_admin => true,
}

pulp_isorepo { 'DataMonster':
  display_name    => 'Data Monster',
  description     => "Cookie's cousin",
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
  remove_missing  => true,
  serve_http      => true,
  serve_https     => false,
}
