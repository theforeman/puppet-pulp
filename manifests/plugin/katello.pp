# Katello pulp plugin
#
# === Parameters:
#
# $package_ensure:: The state or version to install
class pulp::plugin::katello(
  $package_ensure = undef,
) {
  pulp::plugin { 'katello':
    package_name   => 'pulp-katello',
    package_ensure => $package_ensure,
  }
}
