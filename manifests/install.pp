# Pulp Installation Packages
class pulp::install {

  package{ ['pulp-server', 'pulp-selinux', 'pulp-nodes-parent']:
    ensure => installed,
  } ->

  pulp::plugin { ['docker', 'rpm', 'puppet']: }

}
