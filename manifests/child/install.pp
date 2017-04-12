# Pulp Node Install Packages
class pulp::child::install (
  $packages = ['pulp-katello', 'pulp-nodes-child', 'katello-agent'],
) {
  package { $packages:
    ensure => installed,
  }
}
