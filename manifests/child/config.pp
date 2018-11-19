# Pulp Node Configuration
class pulp::child::config(
  $node_certificate = $pulp::node_certificate,
  $verify_ssl = $pulp::node_verify_ssl,
  $ca_path = $pulp::node_server_ca_cert,
  $oauth_user_id = $pulp::node_oauth_effective_user,
  $oauth_key = $pulp::node_oauth_key,
  $oauth_secret = $pulp::node_oauth_secret,
) {
  file { '/etc/pulp/nodes.conf':
    ensure  => 'file',
    content => template('pulp/nodes.conf.erb'),
  }

  # we need to make sure the goferd reads the current oauth credentials to talk
  # to the child node
  File['/etc/pulp/server.conf'] ~> Service['goferd']
}
