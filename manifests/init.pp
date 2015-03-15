# == Class: pulp
#
# Install and configure pulp
#
# === Parameters:
# $version::                    pulp package version, it's passed to ensure parameter of package resource
#                               can be set to specific version number, 'latest', 'present' etc.
#
# $oauth_key::                  The oauth key; defaults to pulp
#
# $oauth_secret::               The oauth secret; defaults to secret
#
# $messaging_url::              URL for the AMQP server that Pulp will use to
#                               communicate with nodes.
#
# $messaging_ca_cert:           The CA cert to authenicate against the AMQP server.
#
# $messaging_client_cert::      The client certificate signed by the CA cert
#                               above to authenticate.
#
# $broker_url::                 URL for the Celery broker that Pulp will use to
#                               queue tasks.
#
# $broker_use_ssl::             Set to true if deploying broker for Celery with SSL.
#
# $broker_manage::              Boolean to install and configure the qpid or rabbitmq broker.
#                               Defaults to false
#                               type:boolean
#
# $consumers_ca_cert::          The path to the CA cert that will be used to sign customer
#                               and admin identification certificates
#
# $consumers_ca_key::           The private key for the CA cert
#
# $ssl_ca_cert::                Full path to the CA certificate used to sign the Pulp
#                               server's SSL certificate; consumers will use this to verify the
#                               Pulp server's SSL certificate during the SSL handshake
#
# $ssl_verify_client::          Enforce use of SSL authentication for yum repos access
#
# $consumers_crl::              Certificate revocation list for consumers which
#                               are no valid (have had their client certs
#                               revoked)
#
# $ssl_ca_cert::                The SSL cert that will be used by Pulp to
#                               verify the connection
#
# $default_login::              Initial login; defaults to admin
#
# $default_password::           Initial password; defaults to 32 character randomly generated password
#
# $repo_auth::                  Boolean to determine whether repos managed by
#                               pulp will require authentication. Defaults
#                               to true
#                               type:boolean
#
# $reset_data::                 Boolean to reset the data in MongoDB. Defaults
#                               to false
#                               type:boolean
#
# $reset_cache::                Boolean to flush the cache. Defaults to false
#                               type:boolean
#
# $proxy_url::                  URL of the proxy server
#
# $proxy_port::                 Port the proxy is running on
#                               type:integer
#
# $proxy_username::             Proxy username for authentication
#
# $proxy_password::             Proxy password for authentication
#
# $num_workers::                Number of Pulp workers to use
#                               defaults to number of processors and maxs at 8
#                               type:integer
#
# $enable_rpm::                 Boolean to enable rpm plugin. Defaults
#                               to true
#                               type:boolean
#
# $enable_docker::              Boolean to enable docker plugin. Defaults
#                               to false
#                               type:boolean
#
# $enable_puppet::              Boolean to enable puppet plugin. Defaults
#                               to false
#                               type:boolean
#
# $enable_nodes::               Boolean to enable puppet nodes. Defaults
#                               to false
#                               type:boolean
#
# $enable_http::                Boolean to enable http access to rpm repos. Defaults
#                               to false
#                               type:boolean
#
# $db_manage::                  Boolean to install and configure the mongodb. Defaults
#                               to false
#                               type:boolean
#
class pulp (
  $version                   = $pulp::params::version,
  $oauth_key                 = $pulp::params::oauth_key,
  $oauth_secret              = $pulp::params::oauth_secret,
  $messaging_url             = $pulp::params::messaging_url,
  $messaging_ca_cert         = $pulp::params::messaging_ca_cert,
  $messaging_client_cert     = $pulp::params::messaging_client_cert,
  $broker_url                = $pulp::params::broker_url,
  $broker_use_ssl            = $pulp::params::broker_use_ssl,
  $broker_manage             = $pulp::params::broker_manage,
  $consumers_ca_cert         = $pulp::params::consumers_ca_cert,
  $consumers_ca_key          = $pulp::params::consumers_ca_key,
  $consumers_crl             = $pulp::params::consumers_crl,
  $ssl_ca_cert               = $pulp::params::ssl_ca_cert,
  $ssl_verify_client         = $pulp::params::ssl_verify_client,
  $default_password          = $pulp::params::default_password,
  $repo_auth                 = $pulp::params::repo_auth,
  $reset_data                = $pulp::params::reset_data,
  $reset_cache               = $pulp::params::reset_cache,
  $proxy_url                 = $pulp::params::proxy_url,
  $proxy_port                = $pulp::params::proxy_port,
  $proxy_username            = $pulp::params::proxy_username,
  $proxy_password            = $pulp::params::proxy_password,
  $num_workers               = $pulp::params::num_workers,
  $message_broker            = $pulp::params::message_broker,
  $enable_docker             = $pulp::params::enable_docker,
  $enable_rpm                = $pulp::params::enable_rpm,
  $enable_puppet             = $pulp::params::enable_puppet,
  $enable_parent_node        = $pulp::params::enable_parent_node,
  $enable_child_node         = $pulp::params::enable_child_node,
  $enable_http               = $pulp::params::enable_http,
  $db_manage                 = $pulp::params::db_manage,
  $node_certificate          = $pulp::params::node_certificate,
  $node_verify_ssl           = $pulp::params::node_verify_ssl,
  $node_server_ca_cert       = $pulp::params::node_server_ca_cert,
  $node_oauth_effective_user = $pulp::params::node_oauth_effective_user,
  $node_oauth_key            = $pulp::params::node_oauth_key,
  $node_oauth_secret         = $pulp::params::node_oauth_secret,
) inherits pulp::params {
  validate_bool($repo_auth)
  validate_bool($reset_data)
  validate_bool($reset_cache)

  validate_bool($enable_docker)
  validate_bool($enable_rpm)
  validate_bool($enable_puppet)
  validate_bool($enable_http)
  validate_bool($db_manage)
  validate_bool($broker_manage)
  validate_bool($enable_parent_node)
  validate_bool($enable_child_node)

  include ::apache
  include ::apache::mod::wsgi
  include ::apache::mod::ssl
  include ::mongodb::client
  include ::qpid::client

  include pulp::database
  include pulp::broker

  if $enable_child_node {
    class{'pulp::agent': version => $version}
  }

  class { 'pulp::install': } ~>
  class { 'pulp::config': } ~>
  class { 'pulp::service': } ~>
  Service['httpd'] ->
  Class[pulp]

  Class['mongodb::client'] -> Class['pulp::config']
  Class['qpid::client'] -> Class['pulp::service']
}
