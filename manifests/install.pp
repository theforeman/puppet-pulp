# Pulp Installation Packages
# @api private
class pulp::install {
  package { ['pulp-server', 'pulp-selinux', 'python-pulp-streamer']: ensure => $pulp::version, }

  $python_package_prefix = $facts['operatingsystemmajrelease'] ? {
    '7'     => 'python',
    default => 'python2',
  }

  if $pulp::messaging_transport == 'qpid' {
    ensure_packages(["${python_package_prefix}-gofer-qpid"], {
        ensure => $pulp::messaging_version,
      }
    )
  }

  if $pulp::messaging_transport == 'rabbitmq' {
    ensure_packages(["${python_package_prefix}-gofer-amqp"], {
        ensure => $pulp::messaging_version,
      }
    )
  }

  if $pulp::enable_katello {
    package { ['pulp-katello']: ensure => $pulp::version, }
  }

  if $pulp::enable_parent_node {
    package { ['pulp-nodes-parent']: ensure => $pulp::version, }
  }

  if $pulp::enable_rpm or $pulp::enable_iso {
    package { ['pulp-rpm-plugins']: ensure => $pulp::version, }
  }

  if $pulp::enable_deb {
    package { ['pulp-deb-plugins']: ensure => $pulp::version, }
  }

  if $pulp::enable_docker {
    package { ['pulp-docker-plugins']: ensure => $pulp::version, }
  }

  if $pulp::enable_puppet {
    package { ['pulp-puppet-plugins']: ensure => $pulp::version, }
  }

  if $pulp::enable_python {
    package { ['pulp-python-plugins']: ensure => $pulp::version, }
  }

  if $pulp::enable_ostree {
    ensure_packages(['ostree'])
    package { ['pulp-ostree-plugins']: ensure => $pulp::version, }
  }
}
