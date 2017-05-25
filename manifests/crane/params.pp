# Default params for Crane
class pulp::crane::params {
  $ca_cert  = undef
  $cert = undef
  $key = undef
  $debug = false
  $port = 5000

  $data_dir = '/var/lib/pulp/published/docker/v2/app'
  $data_dir_polling_interval = 60
}
