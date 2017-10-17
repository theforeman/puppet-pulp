# == Class: pulp::crane
#
# Install and configure Crane
#
# === Parameters:
#
# $debug::                      Enable debug logging
#
# $key::                        Path to the SSL key for https
#
# $cert::                       Path to the SSL certificate for https
#
# $ca_cert::                    Path to the SSL CA cert for https
#
# $port::                       Port for Crane to run on
#
# $data_dir::                   Directory containing docker v1/v2 artifacts published by pulp
#
# $data_dir_polling_interval::  The number of seconds between checks for updates to metadata files in the data_dir
#
# $ssl_protocol::               SSLProtocol configuration to use
class pulp::crane (
  Boolean $debug = $::pulp::crane::params::debug,
  Integer[0, 65535] $port = $::pulp::crane::params::port,
  Stdlib::Absolutepath $data_dir = $::pulp::crane::params::data_dir,
  Integer[0] $data_dir_polling_interval = $::pulp::crane::params::data_dir_polling_interval,
  Stdlib::Absolutepath $key = $::pulp::crane::params::key,
  Stdlib::Absolutepath $cert = $::pulp::crane::params::cert,
  Stdlib::Absolutepath $ca_cert = $::pulp::crane::params::ca_cert,
  Optional[String] $ssl_protocol = $::pulp::crane::params::ssl_protocol,
) inherits pulp::crane::params {
  class { '::pulp::crane::install': } ~>
  class { '::pulp::crane::config': } ~>
  class { '::pulp::crane::apache': } ->
  Class['pulp::crane']
}
