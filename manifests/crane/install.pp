# Install Crane and dependencies
class pulp::crane::install {

  package{ ['python-crane']:
    ensure => installed,
  }
}
