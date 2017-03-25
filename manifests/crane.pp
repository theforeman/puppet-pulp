# == Class: pulp::crane
#
# Install and configure Crane
#
# === Parameters:
#
# $debug::                      Enable debug logging
#                               type:boolean
#
# $key::                        Path to the SSL key for https
#
# $cert::                       Path to the SSL certificate for https
#
# $ca_cert::                    Path to the SSL CA cert for https
#
# $port::                       Port for Crane to run on
#                               type:integer
#
# $data_dir::                   Directory containing docker v1/v2 artifacts published by pulp
#
# $data_dir_polling_interval::  The number of seconds between checks for updates to metadata files in the data_dir
#                               type:integer
class pulp::crane (
  $debug                     = $::pulp::crane::params::debug,
  $port                      = $::pulp::crane::params::port,
  $data_dir                  = $::pulp::crane::params::data_dir,
  $data_dir_polling_interval = $::pulp::crane::params::data_dir_polling_interval,
  $key                       = $::pulp::crane::params::key,
  $cert                      = $::pulp::crane::params::cert,
  $ca_cert                   = $::pulp::crane::params::ca_cert,
) inherits pulp::crane::params {

  validate_bool($debug)
  validate_absolute_path($data_dir, $key, $cert, $ca_cert)
  validate_integer($port)
  validate_integer($data_dir_polling_interval)

  class { '::pulp::crane::install': } ~>
  class { '::pulp::crane::config': } ~>
  class { '::pulp::crane::apache': } ->
  Class['pulp::crane']
}
