#
# == Class: pulp::child
#
# Install and configure Pulp node
#
class pulp::child (
  $parent_fqdn           = undef,
  $oauth_effective_user  = 'admin',
  $oauth_key             = 'key',
  $oauth_secret          = 'secret',
  $ssl_cert              = '/etc/pki/pulp/ssl_apache.crt',
  $ssl_key               = '/etc/pki/pulp/ssl_apache.key',
  $server_ca_cert        = '/etc/pki/pulp/ca.crt'
) {

  unless $parent_fqdn {
    fail('$parent_fqdn has to be specified')
  }

  class { '::pulp::child::install': } ~>
  class { '::pulp::child::config': } ~>
  class { '::pulp::child::service': }
}
