# The resources in this file serve as examples and are also used in the automated acceptance testing
class { '::pulp':
  manage_repo  => true,
  # https://github.com/theforeman/puppet-pulp/issues/138
  ssl_username => '',
  enable_admin => true,
}

# No parameters/properties are mandatory
pulp_rpmrepo { 'defaults_example':}

# But there are several you can set
pulp_rpmrepo { 'Yummy':
  display_name      => 'Very tasty',
  description       => 'Yummy has the best food',
  note              => {'a' => 'b'},
  feed              => 'https://example.com/feed',
  validate          => true,
  skip              => ['drpm'],
  feed_ca_cert      => '/etc/pki/pulp/ca.crt',
  verify_feed_ssl   => true,
  feed_cert         => '/etc/pki/pulp/rsa_pub.key',
  feed_key          => '/etc/pki/pulp/rsa.key',
  proxy_host        => 'proxy.example.com',
  proxy_port        => 8080,
  max_downloads     => 10,
  max_speed         => 10000,
  remove_missing    => true,
  retain_old_count  => 3,
  relative_url      => 'yummy',
  serve_http        => 'TRUE', # Boolean properties accept actual booleans, or boolean like strings
  serve_https       => 'no',
  generate_sqlite   => true,
  host_ca           => '/etc/pki/pulp/ca.crt',
  auth_ca           => '/etc/pki/pulp/ca.crt',
  repoview          => true,
  require_signature => false,
  download_policy   => 'on_demand',
}
# Proxy passwords are never idempotent since we can't retrieve the
# password from the API. user requires a password
#proxy_user               => 'puser',
#proxy_pass               => 'ppassword',

# Same idempotency problem for basicauth
#basicauth_user    => 'username',
#basicauth_pass    => 'password',

# TODO
#auth_cert                => '',
#checksum_type            => '',
#gpg_key                  => '',
#updateinfo_checksum_type => '',
#allowed_keys             => [],
