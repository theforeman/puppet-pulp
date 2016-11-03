# == Class: pulp::crane
#
# Install and configure Crane
#
# === Parameters:
#
# $key::     Path to the SSL key for https
#
# $cert::    Path to the SSL certificate for https
#
# $ca_cert:: Path to the SSL CA cert for https
#
# $port::     Port for Crane to run on
#             type:integer
#
# $data_dir:: Directory containing docker v1/v2 artifacts published by pulp
#
class pulp::crane (
  $port     = $pulp::crane::params::port,
  $data_dir = $pulp::crane::params::data_dir,
  $key      = $pulp::crane::params::key,
  $cert     = $pulp::crane::params::cert,
  $ca_cert  = $pulp::crane::params::ca_cert,
  ) inherits pulp::crane::params {

  validate_absolute_path($data_dir, $key, $cert, $ca_cert)
  validate_integer($port)

  class { '::pulp::crane::install': } ~>
  class { '::pulp::crane::config': } ~>
  class { '::pulp::crane::apache': } ->
  Class['::pulp::crane']
}

