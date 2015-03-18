# Pulp Installation Packages
class pulp::install {
  package { ['pulp-server', 'pulp-selinux', 'pulp-nodes-parent']: ensure => $pulp::version, }

  if $pulp::enable_rpm {
    package { ['pulp-rpm-plugins']: ensure => $pulp::version, }
  }

  if $pulp::enable_docker {
    package { ['pulp-docker-plugins']: ensure => $pulp::version, }
  }

  if $pulp::enable_puppet {
    package { ['pulp-puppet-plugins']: ensure => $pulp::version, }
  }
}
