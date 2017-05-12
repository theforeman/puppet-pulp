# Pulp python plugin
#
# === Parameters:
#
# $package_ensure:: The state or version to install
class pulp::plugin::python(
  $package_ensure = undef,
) {
  pulp::plugin { 'python':
    package_ensure => $package_ensure,
    apache_config  => file('pulp/plugins/python/apache.conf'),
  }
}
