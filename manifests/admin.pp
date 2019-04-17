# Install and configure Pulp admin
#
# @param version
#   Pulp admin package version, it's passed to ensure parameter of package
#   resource can be set to specific version number, 'latest', 'present' etc.
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
# @param ca_path
#   This is a path to a file of concatenated trusted CA certificates, or to a
#   directory of trusted CA certificates (with openssl-style hashed symlinks,
#   one certificate per file).
#
# @param upload_chunk_size
#   upload_chunk_size
#
# @param role
#   The client role.
#
# @param extensions_dir
#   The location of admin client extensions.
#
# @param id_cert_dir
#   The location of the directory where the Pulp user ID certificate is stored.
#
# @param id_cert_filename
#   The name of the file containing the PEM encoded client private key and
#   X.509 certificate. This file is downloaded and stored here during login.
#
# @param upload_working_dir
#   Directory where status files for in progress uploads will be stored
#
# @param log_filename
#   The location of the admin client log file.
#
# @param call_log_filename
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
# @param enable_puppet
#   Install puppet extension. Defaults to false.
#
# @param enable_deb
#   Install deb extension. Defaults to false.
#
# @param enable_docker
#   Install docker extension. Defaults to false.
#
# @param enable_nodes
#   Install nodes extension. Defaults to false.
#
# @param enable_python
#   Install python extension. Defaults to false.
#
# @param enable_ostree
#   Install ostree extension. Defaults to false.
#
# @param enable_rpm
#   Install rpm extension. Defaults to true.
#
# @param enable_iso
#   Install ISO extension. Defaults to true.
#
# @param puppet_upload_working_dir
#   Directory where status files for in progress uploads will be stored
#
# @param puppet_upload_chunk_size
#   Maximum amount of data (in bytes) sent for an upload in a single request
#
# @param login_method
#   The method to ensure root can use pulp-admin. Choose none to disable this
#   behaviour.
#
# @param username
#   The username to login with
#
# @param password
#   The password to login with. If left undefined then no login will be
#   performed.
#
class pulp::admin (
  String $version = $pulp::admin::params::version,
  String $host = $pulp::admin::params::host,
  Integer[1, 65535] $port = $pulp::admin::params::port,
  String $api_prefix = $pulp::admin::params::api_prefix,
  Boolean $verify_ssl = $pulp::admin::params::verify_ssl,
  Stdlib::Absolutepath $ca_path = $pulp::admin::params::ca_path,
  Integer[0] $upload_chunk_size = $pulp::admin::params::upload_chunk_size,
  String $role = $pulp::admin::params::role,
  Stdlib::Absolutepath $extensions_dir = $pulp::admin::params::extensions_dir,
  String $id_cert_dir = $pulp::admin::params::id_cert_dir,
  String $id_cert_filename = $pulp::admin::params::id_cert_filename,
  String $upload_working_dir = $pulp::admin::params::upload_working_dir,
  String $log_filename = $pulp::admin::params::log_filename,
  String $call_log_filename = $pulp::admin::params::call_log_filename,
  Integer[0] $poll_frequency_in_seconds = $pulp::admin::params::poll_frequency_in_seconds,
  Boolean $enable_color = $pulp::admin::params::enable_color,
  Boolean $wrap_to_terminal = $pulp::admin::params::wrap_to_terminal,
  Integer[0] $wrap_width = $pulp::admin::params::wrap_width,
  Boolean $enable_puppet = $pulp::admin::params::enable_puppet,
  Boolean $enable_deb = $pulp::admin::params::enable_deb,
  Boolean $enable_docker = $pulp::admin::params::enable_docker,
  Boolean $enable_nodes = $pulp::admin::params::enable_nodes,
  Boolean $enable_python = $pulp::admin::params::enable_python,
  Boolean $enable_ostree = $pulp::admin::params::enable_ostree,
  Boolean $enable_rpm = $pulp::admin::params::enable_rpm,
  Boolean $enable_iso = $pulp::admin::params::enable_iso,
  String $puppet_upload_working_dir = $pulp::admin::params::puppet_upload_working_dir,
  Integer[0] $puppet_upload_chunk_size = $pulp::admin::params::puppet_upload_chunk_size,
  Enum['none', 'file', 'login'] $login_method = $pulp::admin::params::login_method,
  String $username = $pulp::admin::params::username,
  Optional[String] $password = $pulp::admin::params::username,
) inherits pulp::admin::params {
  if $login_method != 'none' {
    assert_type(String, $password)
  }

  contain pulp::admin::install
  contain pulp::admin::config
  contain pulp::admin::login

  Class['pulp::admin::install'] -> Class['pulp::admin::config'] -> Class['pulp::admin::login']
}
