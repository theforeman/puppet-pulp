# Default params for Crane
class pulp::crane::params {
  $port = 5000
  $data_dir = '/var/lib/crane/metadata'
  $data_dir_polling_interval = 60
  $key      = undef
  $cert     = undef
  $ca_cert  = undef
}
