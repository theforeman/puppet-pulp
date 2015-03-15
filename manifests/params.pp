# Pulp Master Params
class pulp::params {
  $version = 'installed'

  $oauth_key = 'pulp'
  $oauth_secret = 'secret'

  $messaging_url = "tcp://${::fqdn}:5672"
  $messaging_ca_cert = undef
  $messaging_client_cert = undef

  $broker_url = "qpid://${::fqdn}:5672"
  $broker_use_ssl = false

  $consumers_ca_cert = '/etc/pki/pulp/ca.crt'
  $consumers_ca_key = '/etc/pki/pulp/ca.key'
  $ssl_ca_cert = '/etc/pki/pulp/ssl_ca.crt'


  $consumers_crl = undef

  $default_login = 'admin'
  $default_password = cache_data('pulp_password', random_password(32))

  $repo_auth         = false
  $enable_http       = false
  $ssl_verify_client = 'require'
  $db_manage         = false
  $broker_manage     = false
  $reset_data        = false
  $reset_cache       = false

  $proxy_url      = undef
  $proxy_port     = undef
  $proxy_username = undef
  $proxy_password = undef

  $num_workers = min($::processorcount, 8)

  $message_broker = 'qpid'

  $enable_rpm         = true
  $enable_docker      = false
  $enable_puppet      = false
  $enable_parent_node = false
  $enable_child_node  = false

  $node_certificate = '/etc/pki/pulp/nodes/node.crt'
  $node_verify_ssl = true
  $node_server_ca_cert = '/etc/pki/pulp/ca.crt'
  $node_oauth_effective_user = 'admin'
  $node_oauth_key = 'key'
  $node_oauth_secret = 'secret'

  $osreleasemajor = regsubst($::operatingsystemrelease, '^(\d+)\..*$', '\1')

  case $::osfamily {
    'RedHat' : {
      case $osreleasemajor {
        '6'     : { $pulp_workers_template = 'upstart_pulp_workers' }
        default : { $pulp_workers_template = 'systemd_pulp_workers' }
      }
    }
    default  : {
      fail("${::hostname}: This module does not support osfamily ${::operatingsystem}")
    }
  }

}
