# Install a pulp plugin
#
# @param package_name The package name
# @param package_ensure The version to install
define pulp::install::plugin(
  Variant[String, Array[String]] $package_name = "pulp-${title}-plugins",
  String $package_ensure = $::pulp::version,
) {
  package { $package_name:
    ensure => $package_ensure,
    before => Class['pulp::config'],
  }
}
