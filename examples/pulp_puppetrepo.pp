class { '::pulp':
  manage_repo   => true,
  # https://github.com/Katello/puppet-pulp/issues/138
  ssl_username  => '',
  enable_admin  => true,
  enable_puppet => true,
}

# Workaround: if we previously had a pulp installation without puppet then
# we need to migrate the database. This requires the services to be
# stopped. https://github.com/Katello/puppet-pulp/issues/197
exec { 'stop services':
  command     => '/bin/systemctl stop pulp_celerybeat pulp_workers pulp_resource_manager pulp_streamer && rm /var/lib/pulp/init.flag',
  subscribe   => Class['pulp::install'],
  before      => Class['pulp::database'],
  refreshonly => true,
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
