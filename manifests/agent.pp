#
# == Class: pulp::agent
#
# Install and configure Pulp agent
# Private class
class pulp::agent ($version, $messaging_transport) {
  if $messaging_transport == 'rabbitmq' {
    package { 'python-gofer-amqp': ensure => $version }
  }

  package { ['pulp-agent', 'gofer']: ensure => $version } ->
  service { 'goferd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true
  }
}
