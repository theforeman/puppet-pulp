# Default params for Crane
class pulp::crane::params {
  $port = 5000
  $data_dir = '/var/lib/pulp/published/docker/v2/app'
  $key      = undef
  $cert     = undef
  $ca_cert  = undef
}
