# Install and configure Pulp consumers
#
# @param ca_path
#   Path to use for the CA
#
# @param version
#   pulp admin package version, it's passed to ensure parameter of package
#   resource can be set to specific version number, 'latest', 'present' etc.
#
# @param enable_puppet
#   Install puppet extension
#
# @param enable_nodes
#   Install nodes extension
#
# @param enable_rpm
#   Install rpm extension
#
# @param host
#   The pulp server hostname
#
# @param port
#   The port providing the RESTful API
#
# @param api_prefix
#   The REST API prefix.
#
# @param verify_ssl
#   Set this to False to configure the client not to verify that the server's
#   SSL cert is signed by a trusted authority
#
# @param rsa_server_pub
#   The pulp server public key used for authentication.
#
# @param rsa_key
#   The RSA private key used for authentication.
#
# @param rsa_pub
#   The RSA public key used for authentication.
#
# @param role
#   The client role.
#
# @param extensions_dir
#   The location of consumer client extensions.
#
# @param repo_file
#   The location of the YUM repository file managed by pulp.
#
# @param mirror_list_dir
#   The location of the directory containing YUM mirror list files that are
#   managed by Pulp.
#
# @param gpg_keys_dir
#   The location of downloaded GPG keys stored by Pulp. The path to the keys
#   stored here are referenced by Pulp's YUM repository file.
#
# @param cert_dir
#   The location of downloaded X.509 certificates stored by Pulp. The path to
#   the certificates stored here are referenced by Pulp's YUM repository file.
#
# @param id_cert_dir
#   The location of the directory where the Pulp consumer ID certificate is stored.
#
# @param id_cert_filename
#   The name of the file containing the PEM encoded consumer private key and
#   X.509 certificate. This file is downloaded and stored here during
#   registration.
#
# @param reboot_permit
#   Permit reboots after package installs if requested.
#
# @param reboot_delay
#   The reboot delay (minutes).
#
# @param logging_filename
#   The location of the consumer client log file.
#
# @param logging_call_log_filename
#   If present, the raw REST responses will be logged to the given file.
#
# @param poll_frequency_in_seconds
#   Number of seconds between requests for any operation that repeatedly polls
#   the server for data.
#
# @param enable_color
#   Set this to false to disable all color escape sequences
#
# @param wrap_to_terminal
#   If wrap_to_terminal is true, any text wrapping will use the current width
#   of the terminal. If false, the value in wrap_width is used.
#
# @param wrap_width
#   The number of characters written before wrapping to the next line.
#
# @param messaging_scheme
#   The broker URL scheme. Either 'tcp' or 'ssl' can be used. The default is 'tcp'.
#
# @param messaging_host
#   The broker host (default: host defined in [server]).
#
# @param messaging_port
#   The broker port number. The default is 5672.
#
# @param messaging_transport
#   The AMQP transport name. Valid options are 'qpid' or 'rabbitmq'. The
#   default is 'qpid'.
#
# @param messaging_vhost
#   The (optional) broker vhost. This is only valid when using 'rabbitmq' as
#   the messaging_transport.
#
# @param messaging_version
#   Determines the version of packages related to the 'messaging transport
#   protocol'.
#
# @param messaging_cacert
#   The (optional) absolute path to a PEM encoded CA certificate to validate
#   the identity of the broker.
#
# @param messaging_clientcert
#   The optional absolute path to PEM encoded key & certificate used to
#   authenticate to the broker with. The id_cert_dir and id_cert_filename are
#   used if this is not defined.
#
# @param profile_minutes
#   The interval in minutes for reporting the installed content profiles.
#
# @param package_profile_enabled
#   Updates package profile information for a registered consumer on pulp server
#
# @param package_profile_verbose
#   Set logging level
#
class pulp::consumer (
  String $version = $pulp::consumer::params::version,
  Boolean $enable_puppet = $pulp::consumer::params::enable_puppet,
  Boolean $enable_nodes = $pulp::consumer::params::enable_nodes,
  Boolean $enable_rpm = $pulp::consumer::params::enable_rpm,
  String $host = $pulp::consumer::params::host,
  Integer $port = $pulp::consumer::params::port,
  String $api_prefix = $pulp::consumer::params::api_prefix,
  Boolean $verify_ssl = $pulp::consumer::params::verify_ssl,
  Stdlib::Absolutepath $ca_path = $pulp::consumer::params::ca_path,
  Stdlib::Absolutepath $rsa_server_pub = $pulp::consumer::params::rsa_server_pub,
  Stdlib::Absolutepath $rsa_key = $pulp::consumer::params::rsa_key,
  Stdlib::Absolutepath $rsa_pub = $pulp::consumer::params::rsa_pub,
  String $role = $pulp::consumer::params::role,
  Stdlib::Absolutepath $extensions_dir = $pulp::consumer::params::extensions_dir,
  Stdlib::Absolutepath $repo_file = $pulp::consumer::params::repo_file,
  Stdlib::Absolutepath $mirror_list_dir = $pulp::consumer::params::mirror_list_dir,
  Stdlib::Absolutepath $gpg_keys_dir = $pulp::consumer::params::gpg_keys_dir,
  Stdlib::Absolutepath $cert_dir = $pulp::consumer::params::cert_dir,
  Stdlib::Absolutepath $id_cert_dir = $pulp::consumer::params::id_cert_dir,
  String $id_cert_filename = $pulp::consumer::params::id_cert_filename,
  Boolean $reboot_permit = $pulp::consumer::params::reboot_permit,
  Integer $reboot_delay = $pulp::consumer::params::reboot_delay,
  String $logging_filename = $pulp::consumer::params::logging_filename,
  String $logging_call_log_filename = $pulp::consumer::params::logging_call_log_filename,
  Integer $poll_frequency_in_seconds = $pulp::consumer::params::poll_frequency_in_seconds,
  Boolean $enable_color = $pulp::consumer::params::enable_color,
  Boolean $wrap_to_terminal = $pulp::consumer::params::wrap_to_terminal,
  Integer $wrap_width = $pulp::consumer::params::wrap_width,
  String $messaging_scheme = $pulp::consumer::params::messaging_scheme,
  String $messaging_host = $pulp::consumer::params::messaging_host,
  Integer[0, 65535] $messaging_port = $pulp::consumer::params::messaging_port,
  String $messaging_transport = $pulp::consumer::params::messaging_transport,
  Optional[String] $messaging_vhost = $pulp::consumer::params::messaging_vhost,
  String $messaging_version = $pulp::consumer::params::messaging_version,
  Optional[Stdlib::Absolutepath] $messaging_cacert = $pulp::consumer::params::messaging_cacert,
  Optional[Stdlib::Absolutepath] $messaging_clientcert = $pulp::consumer::params::messaging_clientcert,
  Integer[0] $profile_minutes = $pulp::consumer::params::profile_minutes,
  Integer $package_profile_enabled = $pulp::consumer::params::package_profile_enabled,
  Integer $package_profile_verbose = $pulp::consumer::params::package_profile_verbose,
) inherits pulp::consumer::params {
  class { 'pulp::consumer::install': } ->
  class { 'pulp::consumer::config': } ~>
  class { 'pulp::consumer::service': }
}
