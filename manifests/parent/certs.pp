# Pulp Master Certs configuration
class pulp::parent::certs (
    $hostname = $::certs::node_fqdn,
    $generate = $::certs::generate,
    $regenerate = $::certs::regenerate,
    $deploy   = $::certs::deploy,
    $ca       = $::certs::default_ca,
    $nodes_cert = '/etc/pki/pulp/nodes/node.crt',
    $messaging_ca_cert = $pulp::params::messaging_ca_cert,
    $messaging_client_cert = $pulp::params::messaging_client_cert
  ) inherits pulp::params {

  # cert for nodes authenitcation
  cert { "${pulp::parent::certs::hostname}-parent-cert":
    hostname    => $pulp::parent::certs::hostname,
    common_name => 'pulp-child-node-cert',
    purpose     => client,
    country     => $::certs::country,
    state       => $::certs::state,
    city        => $::certs::sity,
    org         => 'PULP',
    org_unit    => 'NODES',
    expiration  => $::certs::expiration,
    ca          => $ca,
    generate    => $generate,
    regenerate  => $regenerate,
    deploy      => $deploy,
  }

  cert { "${pulp::parent::certs::hostname}-qpid-client-cert":
    hostname    => $pulp::parent::certs::hostname,
    common_name => 'pulp-qpid-client-cert',
    purpose     => client,
    country     => $::certs::country,
    state       => $::certs::state,
    city        => $::certs::sity,
    org         => 'PULP',
    org_unit    => $::certs::org_unit,
    expiration  => $::certs::expiration,
    ca          => $ca,
    generate    => $generate,
    regenerate  => $regenerate,
    deploy      => $deploy,
  }

  if $deploy {
    key_bundle { $pulp::parent::certs::nodes_cert:
      cert => Cert["${pulp::parent::certs::hostname}-parent-cert"],
    }

    key_bundle { $messaging_client_cert:
      cert => Cert["${pulp::parent::certs::hostname}-qpid-client-cert"],
    } ~>
    file { $messaging_client_cert:
      owner   => 'apache',
      group   => 'apache',
      mode    => '0640',
    }
  }
}
