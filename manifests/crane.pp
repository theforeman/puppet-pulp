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
# $ssl_chain::                  Path to the SSL chain file for https
#
# $port::                       Port for Crane to run on
#
# $data_dir::                   Directory containing docker v1/v2 artifacts published by pulp
#
# $data_dir_polling_interval::  The number of seconds between checks for updates to metadata files in the data_dir
#
# $ssl_protocol::               SSLProtocol configuration to use
class pulp::crane (
  Stdlib::Absolutepath $key,
  Stdlib::Absolutepath $cert,
  Stdlib::Absolutepath $ca_cert,

  Boolean $debug = false,
  Stdlib::Port $port = 5000,
  Stdlib::Absolutepath $data_dir = '/var/lib/crane/metadata',
  Integer[0] $data_dir_polling_interval = 60,
  Optional[Stdlib::Absolutepath] $ssl_chain = undef,
  Optional[String] $ssl_protocol = undef,
){

  contain ::pulp::crane::install
  contain ::pulp::crane::config
  contain ::pulp::crane::apache

  Class['pulp::crane::install']
  ~> Class['pulp::crane::config']
  ~> Class['pulp::crane::apache']
}
