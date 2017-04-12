# == Class: pulp
#
# Install and configure pulp
#
# === Parameters:
#
# $version::                    pulp package version, it's passed to ensure parameter of package resource can be set to
#                               specific version number, 'latest', 'present' etc.
#
# $crane_debug::                Whether to enable crane debug logging
#
# $crane_port::                 Port for Crane to run on
#
# $crane_data_dir::             Directory containing docker v1/v2 artifacts published by pulp
#
# $oauth_key::                  Key to enable OAuth style authentication
#
# $oauth_secret::               Shared secret that can be used for OAuth style authentication
#
# $oauth_enabled::              Controls whether OAuth authentication is enabled
#
# $messaging_url::              the url used to contact the broker: <protocol>://<host>:<port>/<virtual-host>
#                               Supported <protocol>  values are 'tcp' or 'ssl' depending on if SSL should be used or not.
#                               The <virtual-host> is optional, and is only applicable to RabbitMQ broker environments.
#
# $messaging_transport::        The type of broker you are connecting to.
#
# $messaging_ca_cert::          Absolute path to PEM encoded CA certificate file, used by Pulp to validate the identity
#                               of the broker using SSL.
#
# $messaging_client_cert::      Absolute path to PEM encoded file containing both the private key and certificate Pulp
#                               should present to the broker to be authenticated by the broker.
#
# $messaging_version::          Determines the version of packages related to the 'messaging transport protocol'.
#
# $broker_url::                 A URL to a broker that Celery can use to queue tasks:
#                               qpid://<username>:<password>@<hostname>:<port>/
#
# $broker_use_ssl::             Whether to require SSL.
#
# $tasks_login_method::         Select the SASL login method used to connect to the broker. This should be left unset
#                               except in special cases such as SSL client certificate authentication.
#
# $ca_cert::                    Full path to the CA certificate that will be used to sign consumer and admin
#                               identification certificates; this must match the value of SSLCACertificateFile in
#                               Apache.
#
# $ca_key::                     Path to the private key for the above CA certificate
#
# $db_name::                    Name of the database to use
#
# $db_seeds::                   Comma-separated list of hostname:port of database replica seed hosts
#
# $db_username::                The user name to use for authenticating to the MongoDB server
#
# $db_password::                The password to use for authenticating to the MongoDB server
#
# $db_replica_set::             The name of replica set configured in MongoDB, if one is in use
#
# $db_ssl::                     Whether to connect to the database server using SSL.
#
# $db_ssl_keyfile::             A path to the private keyfile used to identify the local connection against mongod. If
#                               included with the certfile then only the ssl_certfile is needed.
#
# $db_ssl_certfile::            The certificate file used to identify the local connection against mongod.
#
# $db_verify_ssl::              Specifies whether a certificate is required from the other side of the connection, and
#                               whether it will be validated if provided. If it is true, then the ca_certs parameter
#                               must point to a file of CA certificates used to validate the connection.
#
# $db_ca_path::                 The ca_certs file contains a set of concatenated "certification authority" certificates,
#                               which are used to validate certificates passed from the other end of the connection.
#
# $db_unsafe_autoretry::        If true, retry commands to the database if there is a connection error.
#                               Warning: if set to true, this setting can result in duplicate records.
#
# $db_write_concern::           Write concern of 'majority' or 'all'. When 'all' is specified, 'w' is set to number of
#                               seeds specified. For version of MongoDB < 2.6, replica_set must also be specified.
#                               Please note that 'all' will cause Pulp to halt if any of the replica set members is not
#                               available. 'majority' is used by default
#
# $server_name::                Hostname the admin client and consumers should use when accessing the server
#
# $key_url::                    Path within the URL to use for GPG keys
#
# $ks_url::                     Path within the URL to use for kickstart trees
#
# $debugging_mode::             Whether to enable Pulp's debugging capabilities
#
# $log_level::                  The desired logging level. Options are: CRITICAL, ERROR, WARNING, INFO, DEBUG, and
#                               NOTSET.
#
# $server_working_directory::   Path to where pulp workers can create working directories needed to complete tasks
#
# $rsa_key::                    The RSA private key used for authentication.
#
# $rsa_pub::                    The RSA public key used for authentication.
#
# $https_cert::                 Apache public certificate for ssl
#
# $https_key::                  Apache private certificate for ssl
#
# $https_chain::                apache chain file for ssl
#
# $ssl_username::               Value to use for SSLUsername directive in apache vhost. Defaults to SSL_CLIENT_S_DN_CN.
#                               Set an empty string or false to unset directive.
#
# $consumers_crl::              Certificate revocation list for consumers which are no valid (have had their client
#                               certs revoked)
#
# $user_cert_expiration::       Number of days a user certificate is valid
#
# $default_login::              Default admin username of the Pulp server; this user will be the first time the server
#                               is started
#
# $default_password::           Default password for admin when it is first created; this should be changed once the
#                               server is operational
#
# $repo_auth::                  Whether to determine whether repos managed by pulp will require authentication.
#
# $consumer_cert_expiration::   Number of days a consumer certificate is valid
#
# $disabled_authenticators::    List of repo authenticators to disable.
#
# $additional_wsgi_scripts::    Hash of additional paths and WSGI script locations for Pulp vhost
#
# $reset_cache::                Whether to force a cache flush. Not recommend in a regular puppet environment.
#
# $ssl_verify_client::          Enforce use of SSL authentication for yum repos access
#
# $ssl_protocol::               Versions of the SSL/TLS protocol will be accepted in new connections
#
# $serial_number_path::         Path to the serial number file
#
# $consumer_history_lifetime::  number of days to store consumer events; events older
#                               than this will be purged; set to -1 to disable
#
# $messaging_url::              the url used to contact the broker: <protocol>://<host>:<port>/<virtual-host>
#                               Supported <protocol>  values are 'tcp' or 'ssl' depending on if SSL should be used or not.
#                               The <virtual-host> is optional, and is only applicable to RabbitMQ broker environments.
#
# $messaging_auth_enabled::     Whether to enable message authentication.
#
# $messaging_topic_exchange::   The name of the exchange to use. The exchange must be a topic exchange. The
#                               default 'amq.topic' is a default exchange that is guaranteed to exist on a Qpid broker.
#
# $messaging_event_notifications_enabled:: Whether to enable Pulp event notfications on the message bus.
#
# $messaging_event_notification_url:: The AMQP URL for event notifications.
#
# $email_host::                 Hostname of the MTA pulp should relay through
#
# $email_port::                 Port of the MTA relay
#
# $email_from::                 The "From" address of each email the system sends
#
# $email_enabled::              Whether emails will be sent
#
# $manage_squid::               Whether the Squid configuration is managed. This is used by Pulp Streamer.
#                               Requires the squid module.
#
# $lazy_redirect_host::         The host FQDN or IP to which requests are redirected.
#
# $lazy_redirect_port::         The TCP port to which requests are redirected
#
# $lazy_redirect_path::         The base path to which requests are redirected
#
# $lazy_https_retrieval::       controls whether Pulp uses HTTPS or HTTP to retrieve content from the streamer.
#                               WARNING: Setting this to 'false' is not safe if you wish to use Pulp to provide
#                               repository entitlement enforcement.  It is strongly recommended to keep this set to
#                               'true' and use certificates that are signed by a trusted authority on the web server
#                               that serves as the streamer reverse proxy.
#
# $lazy_download_interval::     The interval in minutes between checks for content cached by the Squid proxy.
#
# $lazy_download_concurrency::  The number of downloads to perform concurrently when downloading content from the Squid
#                               cache.
#
# $proxy_url::                  URL of the proxy server
#
# $proxy_port::                 Port the proxy is running on
#
# $proxy_username::             Proxy username for authentication
#
# $proxy_password::             Proxy password for authentication
#
# $yum_max_speed::              The maximum download speed for a Pulp task, such as a sync. (e.g. "4 Kb" or 1Gb")
#
# $num_workers::                Number of Pulp workers to use.
#
# $enable_katello::             Whether to enable pulp katello plugin.
#
# $enable_crane::               Whether to enable crane docker repository
#
# $max_tasks_per_child::        Number of tasks after which the worker is restarted and the memory it allocated is
#                               returned to the system
#
# $enable_rpm::                 Whether to enable rpm plugin.
#
# $enable_docker::              Whether to enable docker plugin.
#
# $enable_puppet::              Whether to enable puppet plugin.
#
# $enable_python::              Whether to enable python plugin.
#
# $enable_ostree::              Whether to enable ostree plugin.
#
# $enable_parent_node::         Whether to enable pulp parent nodes.
#
# $enable_http::                Whether to enable http access to rpm repos.
#
# $manage_httpd::               Whether to install and configure the httpd server.
#
# $manage_plugins_httpd::       Whether to install the enabled pulp plugins apache configs even if $manage_httpd is
#                               false.
#
# $manage_broker::              Whether install and configure the qpid or rabbitmq broker.
#
# $manage_db::                  Boolean to install and configure the mongodb.
#
# $node_certificate::           The absolute path to the node SSL certificate
#
# $node_verify_ssl::            Whether to verify node SSL
#
# $node_server_ca_cert::        Server cert for pulp node
#
# $node_oauth_effective_user::  Effective user for node OAuth
#
# $node_oauth_key::             The oauth key used to authenticate to the parent node
#
# $node_oauth_secret::          The oauth secret used to authenticate to the parent node
#
# $max_keep_alive::             Configuration value for apache MaxKeepAliveRequests
#
# $puppet_wsgi_processes::      Number of WSGI processes to spawn for the puppet webapp
#
# $migrate_db_timeout::         Change the timeout for pulp-manage-db
#
# $show_conf_diff::             Allow showing diff for changes in server.conf and importer.json;
#                               Warning: may display and log passwords contained in these files.
#
# $enable_profiling::           Turns on cProfiling of tasks in Pulp
#
# $profiling_directory::        Directory to store task profiling data in
#
# $ldap_url::                   URL to use for LDAP authentication. Defaults
#                               to undef (internal authentication is used)
#                               type:string
#
# $ldap_bind_dn::               LDAP Bind DN
#                               type:string
#
# $ldap_bind_password::         LDAP Password
#                               type:string
#
# $ldap_remote_user_attribute:: LDAP Remote User Attribute. Defaults to 'sAMAccountName'
#                               type:string
#
class pulp (
  $version                   = $pulp::params::version,
  $crane_debug               = $pulp::params::crane_debug,
  $crane_port                = $pulp::params::crane_port,
  $crane_data_dir            = $pulp::params::crane_data_dir,
  $db_name                   = $pulp::params::db_name,
  $db_seeds                  = $pulp::params::db_seeds,
  $db_username               = $pulp::params::db_username,
  $db_password               = $pulp::params::db_password,
  $db_replica_set            = $pulp::params::db_replica_set,
  $db_ssl                    = $pulp::params::db_ssl,
  $db_ssl_keyfile            = $pulp::params::db_ssl_keyfile,
  $db_ssl_certfile           = $pulp::params::db_ssl_certfile,
  $db_verify_ssl             = $pulp::params::db_verify_ssl,
  $db_ca_path                = $pulp::params::db_ca_path,
  $db_unsafe_autoretry       = $pulp::params::db_unsafe_autoretry,
  $db_write_concern          = $pulp::params::db_write_concern,
  $server_name               = $pulp::params::server_name,
  $key_url                   = $pulp::params::key_url,
  $ks_url                    = $pulp::params::ks_url,
  $default_login             = $pulp::params::default_login,
  $default_password          = $pulp::params::default_password,
  $debugging_mode            = $pulp::params::debugging_mode,
  $log_level                 = $pulp::params::log_level,
  $server_working_directory  = $pulp::params::server_working_directory,
  $rsa_key                   = $pulp::params::rsa_key,
  $rsa_pub                   = $pulp::params::rsa_pub,
  $ca_cert                   = $pulp::params::ca_cert,
  $ca_key                    = $pulp::params::ca_key,
  $https_cert                = $pulp::params::https_cert,
  $https_key                 = $pulp::params::https_key,
  $https_chain               = $pulp::params::https_chain,
  $ssl_username              = $pulp::params::ssl_username,
  $user_cert_expiration      = $pulp::params::user_cert_expiration,
  $consumer_cert_expiration  = $pulp::params::consumer_cert_expiration,
  $serial_number_path        = $pulp::params::serial_number_path,
  $consumer_history_lifetime = $pulp::params::consumer_history_lifetime,
  $oauth_enabled             = $pulp::params::oauth_enabled,
  $oauth_key                 = $pulp::params::oauth_key,
  $oauth_secret              = $pulp::params::oauth_secret,
  $max_keep_alive            = $pulp::params::max_keep_alive,
  $messaging_url             = $pulp::params::messaging_url,
  $messaging_transport       = $pulp::params::messaging_transport,
  $messaging_auth_enabled    = $pulp::params::messaging_auth_enabled,
  $messaging_ca_cert         = $pulp::params::messaging_ca_cert,
  $messaging_client_cert     = $pulp::params::messaging_client_cert,
  $messaging_topic_exchange  = $pulp::params::messaging_topic_exchange,
  $messaging_event_notifications_enabled = $pulp::params::messaging_event_notifications_enabled,
  $messaging_event_notification_url = $pulp::params::messaging_event_notification_url,
  $messaging_version         = $pulp::params::messaging_version,
  $broker_url                = $pulp::params::broker_url,
  $broker_use_ssl            = $pulp::params::broker_use_ssl,
  $tasks_login_method        = $pulp::params::tasks_login_method,
  $email_host                = $pulp::params::email_host,
  $email_port                = $pulp::params::email_port,
  $email_from                = $pulp::params::email_from,
  $email_enabled             = $pulp::params::email_enabled,
  $manage_squid              = $pulp::params::manage_squid,
  $lazy_redirect_host        = $pulp::params::lazy_redirect_host,
  $lazy_redirect_port        = $pulp::params::lazy_redirect_port,
  $lazy_redirect_path        = $pulp::params::lazy_redirect_path,
  $lazy_https_retrieval      = $pulp::params::lazy_https_retrieval,
  $lazy_download_interval    = $pulp::params::lazy_download_interval,
  $lazy_download_concurrency = $pulp::params::lazy_download_concurrency,
  $consumers_crl             = $pulp::params::consumers_crl,
  $reset_cache               = $pulp::params::reset_cache,
  $ssl_verify_client         = $pulp::params::ssl_verify_client,
  $ssl_protocol              = $pulp::params::ssl_protocol,
  $repo_auth                 = $pulp::params::repo_auth,
  $proxy_url                 = $pulp::params::proxy_url,
  $proxy_port                = $pulp::params::proxy_port,
  $proxy_username            = $pulp::params::proxy_username,
  $proxy_password            = $pulp::params::proxy_password,
  $yum_max_speed             = $pulp::params::yum_max_speed,
  $num_workers               = $pulp::params::num_workers,
  $enable_katello            = $pulp::params::enable_katello,
  $enable_crane              = $pulp::params::enable_crane,
  $max_tasks_per_child       = $pulp::params::max_tasks_per_child,
  $enable_docker             = $pulp::params::enable_docker,
  $enable_rpm                = $pulp::params::enable_rpm,
  $enable_puppet             = $pulp::params::enable_puppet,
  $enable_python             = $pulp::params::enable_python,
  $enable_ostree             = $pulp::params::enable_ostree,
  $enable_parent_node        = $pulp::params::enable_parent_node,
  $enable_http               = $pulp::params::enable_http,
  $manage_broker             = $pulp::params::manage_broker,
  $manage_db                 = $pulp::params::manage_db,
  $manage_httpd              = $pulp::params::manage_httpd,
  $manage_plugins_httpd      = $pulp::params::manage_plugins_httpd,
  $node_certificate          = $pulp::params::node_certificate,
  $node_verify_ssl           = $pulp::params::node_verify_ssl,
  $node_server_ca_cert       = $pulp::params::node_server_ca_cert,
  $node_oauth_effective_user = $pulp::params::node_oauth_effective_user,
  $node_oauth_key            = $pulp::params::node_oauth_key,
  $node_oauth_secret         = $pulp::params::node_oauth_secret,
  $disabled_authenticators   = $pulp::params::disabled_authenticators,
  $additional_wsgi_scripts   = $pulp::params::additional_wsgi_scripts,
  $puppet_wsgi_processes     = $pulp::params::puppet_wsgi_processes,
  $migrate_db_timeout        = $pulp::params::migrate_db_timeout,
  $show_conf_diff            = $pulp::params::show_conf_diff,
  $enable_profiling          = $pulp::params::enable_profiling,
  $profiling_directory       = $pulp::params::profiling_directory,
  $ldap_url                  = $pulp::params::ldap_url,
  $ldap_bind_dn              = $pulp::params::ldap_bind_dn,
  $ldap_bind_password        = $pulp::params::ldap_bind_password,
  $ldap_remote_user_attribute = $pulp::params::ldap_remote_user_attribute,
) inherits pulp::params {
  validate_bool($enable_katello)
  validate_bool($enable_crane)
  validate_bool($enable_docker)
  validate_bool($enable_rpm)
  validate_bool($enable_puppet)
  validate_bool($enable_python)
  validate_bool($enable_ostree)
  validate_bool($enable_http)
  validate_bool($manage_db)
  validate_bool($manage_broker)
  validate_bool($manage_httpd)
  validate_bool($manage_plugins_httpd)
  validate_bool($enable_parent_node)
  validate_bool($repo_auth)
  validate_bool($reset_cache)
  validate_bool($db_unsafe_autoretry)
  validate_bool($messaging_event_notifications_enabled)
  validate_bool($manage_squid)
  validate_bool($lazy_https_retrieval)
  validate_bool($show_conf_diff)
  validate_array($disabled_authenticators)
  validate_hash($additional_wsgi_scripts)
  validate_integer($max_keep_alive)
  validate_bool($enable_profiling)
  validate_absolute_path($profiling_directory)

  if $max_tasks_per_child {
    validate_integer($max_tasks_per_child)
  }

  if $https_cert {
    validate_absolute_path($https_cert)
  }
  if $https_key {
    validate_absolute_path($https_key)
  }
  if $https_chain {
    validate_absolute_path($https_chain)
  }
  if $ssl_protocol != undef {
    validate_string($ssl_protocol)
  }

  if $yum_max_speed {
    validate_string($yum_max_speed)
    $real_yum_max_speed = to_bytes($yum_max_speed)
  } else {
    $real_yum_max_speed = undef
  }

  if $ldap_url {
    validate_string($ldap_url)
    validate_string($ldap_bind_dn)
    validate_string($ldap_bind_password)
    validate_string($ldap_remote_user_attribute)
  }

  include ::mongodb::client
  include ::pulp::apache
  include ::pulp::database
  include ::pulp::broker

  if $enable_crane {
    class { '::pulp::crane':
      cert     => $https_cert,
      key      => $https_key,
      ca_cert  => $ca_cert,
      port     => $crane_port,
      data_dir => $crane_data_dir,
      debug    => $crane_debug,
    }
  }

  class { '::pulp::install': } ->
  class { '::pulp::config': } ~>
  class { '::pulp::service': } ->
  Class[pulp] ~>
  Service['httpd']
}
