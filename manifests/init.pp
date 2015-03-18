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
# $consumers_ca_cert::          The path to the CA cert that will be used to sign customer
#                               and admin identification certificates
#
# $consumers_ca_key::           The private key for the CA cert
#
# $ssl_ca_cert::                Full path to the CA certificate used to sign the Pulp
#                               server's SSL certificate; consumers will use this to verify the
#                               Pulp server's SSL certificate during the SSL handshake
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
#
# $reset_data::                 Boolean to reset the data in MongoDB. Defaults
#                               to false
#
# $reset_cache::                Boolean to flush the cache. Defaults to false
#
# $proxy_url::                  URL of the proxy server
#
# $proxy_port::                 Port the proxy is running on
#
# $proxy_username::             Proxy username for authentication
#
# $proxy_password::             Proxy password for authentication
#
# $num_workers::                Number of Pulp workers to use
#                               defaults to number of processors and maxs at 8
#
# $enable_rpm::                 Boolean to enable rpm plugin. Defaults
#                               to true
#
# $enable_docker::              Boolean to enable docker plugin. Defaults
#                               to true
#
# $enable_puppet::              Boolean to enable puppet plugin. Defaults
#                               to true
#
class pulp (
  $version                     = $pulp::params::version,
  $oauth_key                   = $pulp::params::oauth_key,
  $oauth_secret                = $pulp::params::oauth_secret,
  $messaging_url               = $pulp::params::messaging_url,
  $messaging_ca_cert           = $pulp::params::messaging_ca_cert,
  $messaging_client_cert       = $pulp::params::messaging_client_cert,
  $broker_url                  = $pulp::params::broker_url,
  $broker_use_ssl              = $pulp::params::broker_use_ssl,
  $consumers_ca_cert           = $pulp::params::consumers_ca_cert,
  $consumers_ca_key            = $pulp::params::consumers_ca_key,
  $consumers_crl               = $pulp::params::consumers_crl,
  $ssl_ca_cert                 = $pulp::params::ssl_ca_cert,
  $default_password            = $pulp::params::default_password,
  $repo_auth                   = true,
  $reset_data                  = false,
  $reset_cache                 = false,
  $proxy_url                   = $pulp::params::proxy_url,
  $proxy_port                  = $pulp::params::proxy_port,
  $proxy_username              = $pulp::params::proxy_username,
  $proxy_password              = $pulp::params::proxy_password,
  $num_workers                 = $pulp::params::num_workers,
  $message_broker              = $pulp::params::message_broker,

  $enable_docker               = $pulp::params::enable_docker,
  $enable_rpm                  = $pulp::params::enable_rpm,
  $enable_puppet               = $pulp::params::enable_puppet,
) inherits pulp::params {

  include ::apache
  include ::apache::mod::wsgi
  include ::apache::mod::ssl

  include ::mongodb::server
  include ::mongodb::client

  if $message_broker == 'qpid' {
    include ::qpid
    Class['qpid'] ->
    Class['pulp::install']
  }

  class { 'pulp::install':
    require => Class['mongodb::server']
  } ~>
  class { 'pulp::config':
    require => [Class['mongodb::server'], Class['mongodb::client']]
  } ~>
  class { 'pulp::service': } ~>
  Service['httpd']
  ->
  Class[pulp]
}
