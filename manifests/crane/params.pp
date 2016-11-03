# Default params for Crane
class pulp::crane::params {
  $ca_cert  = undef
  $cert = undef
  $data_dir = '/var/lib/crane/metadata'
  $data_dir_polling_interval = 60
  $debug = false
  $key = undef
  $port = 5000
}
