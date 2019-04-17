# Pulp Node Install Packages
# @api private
class pulp::child::install (
  $packages = ['pulp-katello', 'pulp-nodes-child', 'katello-agent'],
) {
  package { $packages:
    ensure => installed,
  }
}
