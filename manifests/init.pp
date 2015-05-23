# == Class: pulp
#
# Install and configure pulp
#
# === Parameters:
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
# $https_cert::                 apache public certificate for ssl
#
# $https_key::                  apache private certificate for ssl
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
# $ssl_verify_client::          Enforce use of SSL authentication for yum repos access
#
# $qpid_ssl::                   Enable SSL in qpid or not
#                               type:boolean
#
# $qpid_ssl_cert_db             The location of the Qpid SSL cert database
#
# $qpid_ssl_cert_password_file  Location of the password file for the Qpid SSL cert
#
# $user_groups::                Additional user groups to add the qpid user to
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
# $enable_python::              Boolean to enable python plugin. Defaults
#                               to false
#                               type:boolean
#
# $enable_parent_node::         Boolean to enable pulp parent nodes. Defaults
#                               to false
#                               type:boolean
#
# $enable_child_node::          Boolean to enable pulp child nodes. Defaults
#                               to false
#                               type:boolean
#
# $enable_http::                Boolean to enable http access to rpm repos. Defaults
#                               to false
#                               type:boolean
#
# $manage_httpd::               Boolean to install and configure the httpd server. Defaults
#                               to true
#                               type:boolean
#
class pulp (

  $oauth_key = $pulp::params::oauth_key,
  $oauth_secret = $pulp::params::oauth_secret,

  $messaging_url = $pulp::params::messaging_url,
  $messaging_ca_cert = $pulp::params::messaging_ca_cert,
  $messaging_client_cert = $pulp::params::messaging_client_cert,

  $broker_url = $pulp::params::broker_url,
  $broker_use_ssl = $pulp::params::broker_use_ssl,

  $consumers_ca_cert = $pulp::params::consumers_ca_cert,
  $consumers_ca_key = $pulp::params::consumers_ca_key,
  $https_cert                = $pulp::params::https_cert,
  $https_key                 = $pulp::params::https_key,
  $ssl_ca_cert = $pulp::params::ssl_ca_cert,

  $consumers_crl = $pulp::params::consumers_crl,

  $ssl_ca_cert = $pulp::params::ssl_ca_cert,

  $default_password = $pulp::params::default_password,

  $repo_auth = true,

  $reset_data = false,
  $reset_cache = false,

  $ssl_verify_client         = $pulp::params::ssl_verify_client,
  $qpid_ssl = $pulp::params::qpid_ssl,
  $qpid_ssl_cert_db = $pulp::params::qpid_ssl_cert_db,
  $qpid_ssl_cert_password_file = $pulp::params::qpid_ssl_cert_password_file,

  $proxy_url      = $pulp::params::proxy_url,
  $proxy_port     = $pulp::params::proxy_port,
  $proxy_username = $pulp::params::proxy_username,
  $proxy_password = $pulp::params::proxy_password,

  $num_workers = $pulp::params::num_workers,

  $enable_docker             = $pulp::params::enable_docker,
  $enable_rpm                = $pulp::params::enable_rpm,
  $enable_puppet             = $pulp::params::enable_puppet,
  $enable_python             = $pulp::params::enable_python,
  $enable_parent_node        = $pulp::params::enable_parent_node,
  $enable_child_node         = $pulp::params::enable_child_node,
  $enable_http               = $pulp::params::enable_http,
  $manage_httpd              = $pulp::params::manage_httpd,

  ) inherits pulp::params {
  validate_bool($enable_docker)
  validate_bool($enable_rpm)
  validate_bool($enable_puppet)
  validate_bool($enable_python)
  validate_bool($enable_http)
  include ::pulp::apache

  if (versioncmp($::mongodb_version, '2.6.5') >= 0) {
    $mongodb_pidfilepath = '/var/run/mongodb/mongod.pid'
  } else {
    $mongodb_pidfilepath = '/var/run/mongodb/mongodb.pid'
  }

  class { '::mongodb::globals':
    version => $::mongodb_version, # taken from the custom facts
  }
  class { '::mongodb':
    logpath     => '/var/lib/mongodb/mongodb.log',
    dbpath      => '/var/lib/mongodb',
    pidfilepath => $mongodb_pidfilepath,
  } ~>
  class { '::qpid':
    ssl                    => $qpid_ssl,
    ssl_cert_db            => $qpid_ssl_cert_db,
    ssl_cert_password_file => $qpid_ssl_cert_password_file,
    ssl_cert_name          => 'broker',
    user_groups            => $pulp::user_groups,
  } ~>
  # Make sure we install the mongodb client, used by service-wait to check
  # that the server is up.
  class {'::mongodb::client':} ~>
  class { '::pulp::install':
    require => [Class['mongodb'], Class['qpid']],
  } ~>
  class { '::pulp::config':
    require => [Class['mongodb'], Class['qpid']],
  } ~>
  class { '::pulp::service': } ~>
  Service['httpd']
  ->
  Class[pulp]
}
