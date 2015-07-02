# Pulp Master Params
class pulp::params {
  $manage_httpd = true

  $oauth_key = 'pulp'
  $oauth_secret = 'secret'

  $mongodb_path = '/var/lib/mongodb'

  $messaging_url = 'tcp://localhost:5672'
  $messaging_transport = 'qpid'
  $messaging_ca_cert = undef
  $messaging_client_cert = undef

  $broker_url = "qpid://${::fqdn}:5671"
  $broker_use_ssl = true

  $consumers_ca_cert = '/etc/pki/pulp/ca.crt'
  $consumers_ca_key = '/etc/pki/pulp/ca.key'
  $https_cert  = $consumers_ca_cert
  $https_key   = $consumers_ca_key
  $ssl_ca_cert = '/etc/pki/pulp/ssl_ca.crt'
  $enable_http = false
  $ssl_verify_client = 'require'

  $enable_rpm = true
  $enable_docker = false
  $enable_puppet = false
  $enable_python = false
  $enable_parent_node = false
  $enable_child_node = false

  $consumers_crl = undef

  $manage_db = true
  $manage_broker = true

  $qpid_ssl = true
  $qpid_ssl_cert_db = '/etc/pki/example/nssdb'
  $qpid_ssl_cert_password_file = '/etc/pki/example/nssdb/nss_db_password-file'

  $default_login = 'admin'
  $default_password = cache_data('pulp_password', random_password(32))

  $repo_auth = true

  $user_groups = []

  $proxy_url      = undef
  $proxy_port     = undef
  $proxy_username = undef
  $proxy_password = undef

  $num_workers = min($::processorcount, 8)

  $osreleasemajor = regsubst($::operatingsystemrelease, '^(\d+)\..*$', '\1')

  case $::osfamily{
    'RedHat': {
      case $osreleasemajor {
        '6': {
          $pulp_workers_template = 'upstart_pulp_workers'
        }
        default: {
          $pulp_workers_template = 'systemd_pulp_workers'
        }
      }
    }
    default: {
      fail("${::hostname}: This module does not support osfamily ${::operatingsystem}")
    }
  }

}
