# Install Crane and dependencies
# @api private
class pulp::crane::install {

  package{ ['python-crane']:
    ensure => installed,
  }
}
