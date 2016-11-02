# == Class: pulp::crane
#
# Install and configure Crane
#
# === Parameters:
#
# $port::     Port for Crane to run on
#             type:integer
#
# $data_dir:: Directory containing docker v1/v2 artifacts published by pulp
#
class pulp::crane (
  $port     = $pulp::crane::params::port,
  $data_dir = $pulp::crane::params::data_dir,
  ) inherits pulp::crane::params {

  validate_absolute_path($data_dir)
  validate_integer($port)

  class { '::pulp::crane::install': } ~>
  class { '::pulp::crane::config': } ~>
  class { '::pulp::crane::apache': } ->
  Class['::pulp::crane']
}

