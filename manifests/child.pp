#
# == Class: pulp::child
#
# Install and configure Pulp node
#
class pulp::child (
  String[1] $parent_fqdn,
  String $oauth_effective_user = 'admin',
  String $oauth_key = 'key',
  String $oauth_secret = 'secret',
  Stdlib::Absolutepath $ssl_cert = '/etc/pki/pulp/ssl_apache.crt',
  Stdlib::Absolutepath $ssl_key = '/etc/pki/pulp/ssl_apache.key',
  Stdlib::Absolutepath $server_ca_cert = '/etc/pki/pulp/ca.crt',
) {
  include pulp::child::apache
  include pulp::child::install
  include pulp::child::config
  include pulp::child::service

  Class['pulp::child::install'] -> Class['pulp::child::config'] ~> Class['pulp::child::service']
}
