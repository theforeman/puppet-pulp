#
# == Class: pulp::agent
#
# Install and configure Pulp agent
#
class pulp::agent ($version) {
  package { ['pulp-agent', 'gofer']: ensure => $version } ->
  service { 'goferd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true
  }

  File['/etc/pulp/server.conf'] ~> Service['goferd']
  Class['pulp::config'] ~> Service['goferd']
  Class['pulp::consumer::config'] ~> Service['goferd']
}
