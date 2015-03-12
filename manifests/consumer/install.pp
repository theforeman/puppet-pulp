# Pulp Consumer Install Packages
class pulp::consumer::install {
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
