# Install and configure pulp
#
# @param version
#   pulp package version, it's passed to ensure parameter of package resource
#   can be set to specific version number, 'latest', 'present' etc.
#
# @param crane_debug
#   Whether to enable crane debug logging
#
# @param crane_port
#   Port for Crane to run on
#
# @param crane_data_dir
#   Directory containing docker v1/v2 artifacts published by pulp
#
# @param manage_repo
#   Whether to manage the pulp repository
#
# @param oauth_key
#   Key to enable OAuth style authentication
#
# @param oauth_secret
#   Shared secret that can be used for OAuth style authentication
#
# @param oauth_enabled
#   Controls whether OAuth authentication is enabled
#
# @param messaging_url
#   the url used to contact the broker:
#   <protocol>://<host>:<port>/<virtual-host> Supported <protocol>  values are
#   'tcp' or 'ssl' depending on if SSL should be used or not. The
#   <virtual-host> is optional, and is only applicable to RabbitMQ broker
#   environments.
#
# @param messaging_transport
#   The type of broker you are connecting to.
#
# @param messaging_ca_cert
#   Absolute path to PEM encoded CA certificate file, used by Pulp to validate
#   the identity of the broker using SSL.
#
# @param messaging_client_cert
#   Absolute path to PEM encoded file containing both the private key and
#   certificate Pulp should present to the broker to be authenticated by the
#   broker.
#
# @param messaging_version
#   Determines the version of packages related to the 'messaging transport protocol'.
#
# @param broker_url
#   A URL to a broker that Celery can use to queue tasks:
#   qpid://<username>:<password>@<hostname>:<port>/
#
# @param broker_use_ssl
#   Whether to require SSL.
#
# @param tasks_login_method
#   Select the SASL login method used to connect to the broker. This should be
#   left unset except in special cases such as SSL client certificate
#   authentication.
#
# @param ca_cert
#   Full path to the CA certificate that will be used to sign consumer and
#   admin identification certificates; this must match the value of
#   SSLCACertificateFile in Apache.
#
# @param ca_key
#   Path to the private key for the above CA certificate
#
# @param db_name
#   Name of the database to use
#
# @param db_seeds
#   Comma-separated list of hostname:port of database replica seed hosts
#
# @param db_username
#   The user name to use for authenticating to the MongoDB server
#
# @param db_password
#   The password to use for authenticating to the MongoDB server
#
# @param db_replica_set
#   The name of replica set configured in MongoDB, if one is in use
#
# @param db_ssl
#   Whether to connect to the database server using SSL.
#
# @param db_ssl_keyfile
#   A path to the private keyfile used to identify the local connection
#   against mongod. If included with the certfile then only the ssl_certfile
#   is needed.
#
# @param db_ssl_certfile
#   The certificate file used to identify the local connection against mongod.
#
# @param db_verify_ssl
#   Specifies whether a certificate is required from the other side of the
#   connection, and whether it will be validated if provided. If it is true,
#   then the ca_certs parameter must point to a file of CA certificates used
#   to validate the connection.
#
# @param db_ca_path
#   The ca_certs file contains a set of concatenated "certification authority"
#   certificates, which are used to validate certificates passed from the
#   other end of the connection.
#
# @param db_unsafe_autoretry
#   If true, retry commands to the database if there is a connection error.
#   Warning: if set to true, this setting can result in duplicate records.
#
# @param db_write_concern
#   Write concern of 'majority' or 'all'. When 'all' is specified, 'w' is set
#   to number of seeds specified. For version of MongoDB < 2.6, replica_set
#   must also be specified. Please note that 'all' will cause Pulp to halt if
#   any of the replica set members is not available. 'majority' is used by
#   default
#
# @param server_name
#   Hostname the admin client and consumers should use when accessing the server
#
# @param key_url
#   Path within the URL to use for GPG keys
#
# @param ks_url
#   Path within the URL to use for kickstart trees
#
# @param debugging_mode
#   Whether to enable Pulp's debugging capabilities
#
# @param log_level
#   The desired logging level.
#
# @param log_type
#   The desired logging type: Options are: syslog, console
#
# @param server_working_directory
#   Path to where pulp workers can create working directories needed to complete tasks
#
# @param rsa_key
#   The RSA private key used for authentication.
#
# @param rsa_pub
#   The RSA public key used for authentication.
#
# @param https_cert
#   Apache public certificate for ssl
#
# @param https_key
#   Apache private certificate for ssl
#
# @param https_chain
#   apache chain file for ssl
#
# @param ssl_username
#   Value to use for SSLUsername directive in apache vhost. Defaults to
#   SSL_CLIENT_S_DN_CN. Set an empty string or false to unset directive.
#
# @param consumers_crl
#   Certificate revocation list for consumers which are no valid (have had
#   their client certs revoked)
#
# @param user_cert_expiration
#   Number of days a user certificate is valid
#
# @param default_login
#   Default admin username of the Pulp server; this user will be the first
#   time the server is started
#
# @param default_password
#   Default password for admin when it is first created; this should be
#   changed once the server is operational
#
# @param repo_auth
#   Whether to determine whether repos managed by pulp will require authentication.
#
# @param consumer_cert_expiration
#   Number of days a consumer certificate is valid
#
# @param disabled_authenticators
#   List of repo authenticators to disable.
#
# @param additional_wsgi_scripts
#   Hash of additional paths and WSGI script locations for Pulp vhost
#
# @param reset_cache
#   Whether to force a cache flush. Not recommend in a regular puppet environment.
#
# @param ssl_verify_client
#   Enforce use of SSL authentication for yum repos access
#
# @param ssl_protocol
#   Versions of the SSL/TLS protocol will be accepted in new connections
#
# @param serial_number_path
#   Path to the serial number file
#
# @param consumer_history_lifetime
#   number of days to store consumer events; events older than this will be
#   purged; set to -1 to disable
#
# @param messaging_url
#   the url used to contact the broker:
#   <protocol>://<host>:<port>/<virtual-host> Supported <protocol>  values are
#   'tcp' or 'ssl' depending on if SSL should be used or not.  The
#   <virtual-host> is optional, and is only applicable to RabbitMQ broker
#   environments.
#
# @param messaging_auth_enabled
#   Whether to enable message authentication.
#
# @param messaging_topic_exchange
#   The name of the exchange to use. The exchange must be a topic exchange.
#   The default 'amq.topic' is a default exchange that is guaranteed to exist
#   on a Qpid broker.
#
# @param messaging_event_notifications_enabled
#   Whether to enable Pulp event notfications on the message bus.
#
# @param messaging_event_notification_url
#   The AMQP URL for event notifications.
#
# @param email_host
#   Hostname of the MTA pulp should relay through
#
# @param email_port
#   Port of the MTA relay
#
# @param email_from
#   The "From" address of each email the system sends
#
# @param email_enabled
#   Whether emails will be sent
#
# @param manage_squid
#   Whether the Squid configuration is managed. This is used by Pulp Streamer.
#   Requires the squid module.
#
# @param lazy_redirect_host
#   The host FQDN or IP to which requests are redirected.
#
# @param lazy_redirect_port
#   The TCP port to which requests are redirected
#
# @param lazy_redirect_path
#   The base path to which requests are redirected
#
# @param lazy_https_retrieval
#   Controls whether Pulp uses HTTPS or HTTP to retrieve content from the streamer.
#   WARNING: Setting this to 'false' is not safe if you wish to use Pulp to
#   provide repository entitlement enforcement.  It is strongly recommended to
#   keep this set to 'true' and use certificates that are signed by a trusted
#   authority on the web server that serves as the streamer reverse proxy.
#
# @param lazy_download_interval
#   The interval in minutes between checks for content cached by the Squid proxy.
#
# @param lazy_download_concurrency
#   The number of downloads to perform concurrently when downloading content
#   from the Squid cache.
#
# @param proxy_url
#   URL of the proxy server
#
# @param proxy_port
#   Port the proxy is running on
#
# @param proxy_username
#   Proxy username for authentication
#
# @param proxy_password
#   Proxy password for authentication
#
# @param yum_max_speed
#   The maximum download speed for RPM & ISO Pulp tasks, such as a sync. (e.g.
#   "4 kb" or "1 Gb")
#
# @param yum_gpg_sign_repo_metadata
#   Whether yum repo metadata GPG signing will be enabled
#
# @param num_workers
#   Number of Pulp workers to use.
#
# @param enable_admin
#   Whether to install and configure the admin command
#
# @param enable_katello
#   Whether to enable pulp katello plugin.
#
# @param enable_crane
#   Whether to enable crane docker repository
#
# @param max_tasks_per_child
#   Number of tasks after which the worker is restarted and the memory it
#   allocated is returned to the system
#
# @param enable_rpm
#   Whether to enable rpm plugin.
#
# @param enable_deb
#   Whether to enable deb plugin.
#
# @param enable_iso
#   Whether to enable iso plugin.
#
# @param enable_docker
#   Whether to enable docker plugin.
#
# @param enable_puppet
#   Whether to enable puppet plugin.
#
# @param enable_python
#   Whether to enable python plugin.
#
# @param enable_ostree
#   Whether to enable ostree plugin.
#
# @param enable_parent_node
#   Whether to enable pulp parent nodes.
#
# @param enable_http
#   Whether to enable http access to deb/rpm repos.
#
# @param http_port
#   HTTP port Apache will listen
#
# @param https_port
#   HTTPS port Apache will listen
#
# @param manage_httpd
#   Whether to install and configure the httpd server.
#
# @param manage_plugins_httpd
#   Whether to install the enabled pulp plugins apache configs even if
#   $manage_httpd is false.
#
# @param manage_broker
#   Whether install and configure the qpid or rabbitmq broker.
#
# @param manage_db
#   Boolean to install and configure the mongodb.
#
# @param node_certificate
#   The absolute path to the node SSL certificate
#
# @param node_verify_ssl
#   Whether to verify node SSL
#
# @param node_server_ca_cert
#   Server cert for pulp node
#
# @param node_oauth_effective_user
#   Effective user for node OAuth
#
# @param node_oauth_key
#   The oauth key used to authenticate to the parent node
#
# @param node_oauth_secret
#   The oauth secret used to authenticate to the parent node
#
# @param max_keep_alive
#   Configuration value for apache MaxKeepAliveRequests
#
# @param wsgi_processes
#   Number of WSGI processes to spawn for pulp itself
#
# @param wsgi_max_requests
#   Maximum number of requests for each wsgi worker to process before shutting
#   down and restarting, useful to combat memory leaks.
#
# @param puppet_wsgi_processes
#   Number of WSGI processes to spawn for the puppet webapp
#
# @param migrate_db_timeout
#   Change the timeout for pulp-manage-db
#
# @param show_conf_diff
#   Allow showing diff for changes in server.conf and importer.json.
#   Warning: may display and log passwords contained in these files.
#
# @param enable_profiling
#   Turns on cProfiling of tasks in Pulp
#
# @param profiling_directory
#   Directory to store task profiling data in
#
# @param ldap_url
#   URL to use for LDAP authentication. Defaults to undef (internal
#   authentication is used)
#
# @param ldap_bind_dn
#   LDAP Bind DN
#
# @param ldap_bind_password
#   LDAP Password
#
# @param ldap_remote_user_attribute
#   LDAP Remote User Attribute. Defaults to 'sAMAccountName'
#
# @param worker_timeout
#   The amount of time (in seconds) before considering a worker as missing. If
#   Pulp's mongo database has slow I/O, then setting a higher number may
#   resolve issues where workers are going missing incorrectly. Defaults to 30.
#
class pulp (
  String $version = $pulp::params::version,
  Boolean $crane_debug = $pulp::params::crane_debug,
  Integer[1, 65535] $crane_port = $pulp::params::crane_port,
  Boolean $manage_repo = $pulp::params::manage_repo,
  Stdlib::Absolutepath $crane_data_dir = $pulp::params::crane_data_dir,
  String $db_name = $pulp::params::db_name,
  String $db_seeds = $pulp::params::db_seeds,
  Optional[String] $db_username = $pulp::params::db_username,
  Optional[String] $db_password = $pulp::params::db_password,
  Optional[String] $db_replica_set = $pulp::params::db_replica_set,
  Boolean $db_ssl = $pulp::params::db_ssl,
  Optional[Stdlib::Absolutepath] $db_ssl_keyfile = $pulp::params::db_ssl_keyfile,
  Optional[Stdlib::Absolutepath] $db_ssl_certfile = $pulp::params::db_ssl_certfile,
  Boolean $db_verify_ssl = $pulp::params::db_verify_ssl,
  Stdlib::Absolutepath $db_ca_path = $pulp::params::db_ca_path,
  Boolean $db_unsafe_autoretry = $pulp::params::db_unsafe_autoretry,
  Optional[Enum['majority', 'all']] $db_write_concern = $pulp::params::db_write_concern,
  String $server_name = $pulp::params::server_name,
  String $key_url = $pulp::params::key_url,
  String $ks_url = $pulp::params::ks_url,
  String $default_login = $pulp::params::default_login,
  String $default_password = $pulp::params::default_password,
  Boolean $debugging_mode = $pulp::params::debugging_mode,
  Enum['CRITICAL', 'ERROR', 'WARNING', 'INFO', 'DEBUG', 'NOTSET'] $log_level = $pulp::params::log_level,
  Optional[Stdlib::Absolutepath] $server_working_directory = $pulp::params::server_working_directory,
  Stdlib::Absolutepath $rsa_key = $pulp::params::rsa_key,
  Stdlib::Absolutepath $rsa_pub = $pulp::params::rsa_pub,
  Stdlib::Absolutepath $ca_cert = $pulp::params::ca_cert,
  Stdlib::Absolutepath $ca_key = $pulp::params::ca_key,
  Optional[Stdlib::Absolutepath] $https_cert = $pulp::params::https_cert,
  Optional[Stdlib::Absolutepath] $https_key = $pulp::params::https_key,
  Optional[Stdlib::Absolutepath] $https_chain = $pulp::params::https_chain,
  Variant[String, Boolean] $ssl_username = $pulp::params::ssl_username,
  Integer $user_cert_expiration = $pulp::params::user_cert_expiration,
  Integer $consumer_cert_expiration = $pulp::params::consumer_cert_expiration,
  Stdlib::Absolutepath $serial_number_path = $pulp::params::serial_number_path,
  Integer[-1] $consumer_history_lifetime = $pulp::params::consumer_history_lifetime,
  Boolean $oauth_enabled = $pulp::params::oauth_enabled,
  String $oauth_key = $pulp::params::oauth_key,
  String $oauth_secret = $pulp::params::oauth_secret,
  Integer[0] $max_keep_alive = $pulp::params::max_keep_alive,
  String $messaging_url = $pulp::params::messaging_url,
  Enum['qpid', 'rabbitmq'] $messaging_transport = $pulp::params::messaging_transport,
  Boolean $messaging_auth_enabled = $pulp::params::messaging_auth_enabled,
  Optional[Stdlib::Absolutepath] $messaging_ca_cert = $pulp::params::messaging_ca_cert,
  Optional[Stdlib::Absolutepath] $messaging_client_cert = $pulp::params::messaging_client_cert,
  String $messaging_topic_exchange = $pulp::params::messaging_topic_exchange,
  Boolean $messaging_event_notifications_enabled = $pulp::params::messaging_event_notifications_enabled,
  Optional[String] $messaging_event_notification_url = $pulp::params::messaging_event_notification_url,
  String $messaging_version = $pulp::params::messaging_version,
  String $broker_url = $pulp::params::broker_url,
  Boolean $broker_use_ssl = $pulp::params::broker_use_ssl,
  Optional[String] $tasks_login_method = $pulp::params::tasks_login_method,
  String $email_host = $pulp::params::email_host,
  Integer[1, 65535] $email_port = $pulp::params::email_port,
  Integer[1, 65535] $http_port = $pulp::params::http_port,
  Integer[1, 65535] $https_port = $pulp::params::https_port,
  String $email_from = $pulp::params::email_from,
  Boolean $email_enabled = $pulp::params::email_enabled,
  Boolean $manage_squid = $pulp::params::manage_squid,
  Optional[String] $lazy_redirect_host = $pulp::params::lazy_redirect_host,
  Optional[Integer[1, 65535]] $lazy_redirect_port = $pulp::params::lazy_redirect_port,
  Optional[String] $lazy_redirect_path = $pulp::params::lazy_redirect_path,
  Boolean $lazy_https_retrieval = $pulp::params::lazy_https_retrieval,
  Integer[0] $lazy_download_interval = $pulp::params::lazy_download_interval,
  Integer[0] $lazy_download_concurrency = $pulp::params::lazy_download_concurrency,
  Optional[Stdlib::Absolutepath] $consumers_crl = $pulp::params::consumers_crl,
  Boolean $reset_cache = $pulp::params::reset_cache,
  Enum['none', 'optional', 'require', 'optional_no_ca'] $ssl_verify_client = $pulp::params::ssl_verify_client,
  Variant[Array[String], String] $ssl_protocol = $pulp::params::ssl_protocol,
  Boolean $repo_auth = $pulp::params::repo_auth,
  Optional[String] $proxy_url = $pulp::params::proxy_url,
  Optional[Integer[1, 65535]] $proxy_port = $pulp::params::proxy_port,
  Optional[String] $proxy_username = $pulp::params::proxy_username,
  Optional[String] $proxy_password = $pulp::params::proxy_password,
  Optional[String] $yum_max_speed = $pulp::params::yum_max_speed,
  Boolean $yum_gpg_sign_repo_metadata = $pulp::params::yum_gpg_sign_repo_metadata,
  Integer[0] $num_workers = $pulp::params::num_workers,
  Integer[0] $worker_timeout = $pulp::params::worker_timeout,
  Boolean $enable_admin = $pulp::params::enable_admin,
  Boolean $enable_katello = $pulp::params::enable_katello,
  Boolean $enable_crane = $pulp::params::enable_crane,
  Optional[Integer[0]] $max_tasks_per_child = $pulp::params::max_tasks_per_child,
  Boolean $enable_deb = $pulp::params::enable_deb,
  Boolean $enable_docker = $pulp::params::enable_docker,
  Boolean $enable_rpm = $pulp::params::enable_rpm,
  Boolean $enable_iso = $pulp::params::enable_iso,
  Boolean $enable_puppet = $pulp::params::enable_puppet,
  Boolean $enable_python = $pulp::params::enable_python,
  Boolean $enable_ostree = $pulp::params::enable_ostree,
  Boolean $enable_parent_node = $pulp::params::enable_parent_node,
  Boolean $enable_http = $pulp::params::enable_http,
  Boolean $manage_broker = $pulp::params::manage_broker,
  Boolean $manage_db = $pulp::params::manage_db,
  Boolean $manage_httpd = $pulp::params::manage_httpd,
  Boolean $manage_plugins_httpd = $pulp::params::manage_plugins_httpd,
  Stdlib::Absolutepath $node_certificate = $pulp::params::node_certificate,
  Boolean $node_verify_ssl = $pulp::params::node_verify_ssl,
  Stdlib::Absolutepath $node_server_ca_cert = $pulp::params::node_server_ca_cert,
  String $node_oauth_effective_user = $pulp::params::node_oauth_effective_user,
  String $node_oauth_key = $pulp::params::node_oauth_key,
  String $node_oauth_secret = $pulp::params::node_oauth_secret,
  Array[String] $disabled_authenticators = $pulp::params::disabled_authenticators,
  Hash[String, String] $additional_wsgi_scripts = $pulp::params::additional_wsgi_scripts,
  Integer[1] $wsgi_processes = $pulp::params::wsgi_processes,
  Integer[0] $wsgi_max_requests = $pulp::params::wsgi_max_requests,
  Integer[0] $puppet_wsgi_processes = $pulp::params::puppet_wsgi_processes,
  Integer[0] $migrate_db_timeout = $pulp::params::migrate_db_timeout,
  Boolean $show_conf_diff = $pulp::params::show_conf_diff,
  Boolean $enable_profiling = $pulp::params::enable_profiling,
  Stdlib::Absolutepath $profiling_directory = $pulp::params::profiling_directory,
  Optional[String] $ldap_url = $pulp::params::ldap_url,
  Optional[String] $ldap_bind_dn = $pulp::params::ldap_bind_dn,
  Optional[String] $ldap_bind_password = $pulp::params::ldap_bind_password,
  String $ldap_remote_user_attribute = $pulp::params::ldap_remote_user_attribute,
) inherits pulp::params {
  if $yum_max_speed {
    $real_yum_max_speed = to_bytes($yum_max_speed)
  } else {
    $real_yum_max_speed = undef
  }

  if $ldap_url {
    assert_type(String, $ldap_url)
    assert_type(String, $ldap_bind_dn)
    assert_type(String, $ldap_bind_password)
  }

  if $manage_repo {
    include pulp::repo::upstream
    Class['pulp::repo::upstream'] -> Class['pulp::install']
  }

  include mongodb::client
  include pulp::broker

  if $enable_crane {
    class { 'pulp::crane':
      cert      => $https_cert,
      key       => $https_key,
      ca_cert   => $ca_cert,
      ssl_chain => $https_chain,
      port      => $crane_port,
      data_dir  => $crane_data_dir,
      debug     => $crane_debug,
    }
    contain pulp::crane
  }

  contain pulp::install
  contain pulp::config
  contain pulp::database
  contain pulp::service
  contain pulp::apache

  Class['pulp::install'] -> Class['pulp::config'] -> Class['pulp::database'] ~> Class['pulp::service', 'pulp::apache']
  Class['pulp::config'] ~> Class['pulp::service', 'pulp::apache']

  if $enable_admin {
    if $ssl_username and $ssl_username != '' {
      warning('Using $ssl_username means pulp-admin login doesn\'t work. Falling back to file login but pulp_*repo providers won\'t work')
      $login_method = 'file'
    } else {
      $login_method = 'login'
    }

    class { 'pulp::admin':
      enable_deb    => $enable_deb,
      enable_docker => $enable_docker,
      enable_nodes  => $enable_parent_node,
      enable_ostree => $enable_ostree,
      enable_puppet => $enable_puppet,
      enable_python => $enable_python,
      enable_rpm    => $enable_rpm,
      ca_path       => $ca_cert,
      login_method  => $login_method,
      username      => $default_login,
      password      => $default_password,
      require       => Class['pulp::apache'],
    }
  }
}
