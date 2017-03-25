# Pulp Consumer Install Packages
class pulp::consumer::install {
  if $pulp::consumer::messaging_transport == 'qpid' {
    ensure_packages(['python-gofer-qpid'], {
        ensure => $pulp::consumer::messaging_version,
      }
    )
  }

  if $pulp::consumer::messaging_transport == 'rabbitmq' {
    ensure_packages(['python-gofer-amqp'], {
        ensure => $pulp::consumer::messaging_version,
      }
    )
  }

  package { 'gofer':
    ensure => $pulp::consumer::messaging_version,
  }

  package { ['pulp-consumer-client', 'pulp-agent']:
    ensure => $pulp::consumer::version,
  }

  if $pulp::consumer::enable_puppet {
    package { ['pulp-puppet-consumer-extensions', 'pulp-puppet-handlers']:
      ensure => $pulp::consumer::version,
    }
  }

  if $pulp::consumer::enable_nodes {
    package { 'pulp-nodes-consumer-extensions':
      ensure => $pulp::consumer::version,
    }
  }

  if $pulp::consumer::enable_rpm {
    package { ['pulp-rpm-consumer-extensions', 'pulp-rpm-yumplugins', 'pulp-rpm-handlers']:
      ensure => $pulp::consumer::version,
    }
  }
}
