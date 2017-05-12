# Pulp Installation Packages
# Private class
class pulp::install {
  package { ['pulp-server', 'pulp-selinux', 'python-pulp-streamer']: ensure => $pulp::version, }

  if $pulp::messaging_transport == 'qpid' {
    ensure_packages(['python-gofer-qpid'], {
        ensure => $pulp::messaging_version,
      }
    )
  }

  if $pulp::messaging_transport == 'rabbitmq' {
    ensure_packages(['python-gofer-amqp'], {
        ensure => $pulp::messaging_version,
      }
    )
  }
}
