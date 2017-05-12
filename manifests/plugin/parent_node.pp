# parent node pulp plugin
#
# === Parameters:
#
# $package_ensure:: The state or version to install
# $ssl_verify_client:: SSL client connection verification
class pulp::plugin::parent_node (
  $package_ensure = undef,
  Enum['none', 'optional', 'require', 'optional_no_ca'] $ssl_verify_client = $::pulp::ssl_verify_client,
) {
  pulp::plugin { 'nodes':
    package_name   => 'pulp-nodes-parent',
    package_ensure => $package_ensure,
    apache_config  => template('pulp/plugins/parent_node/apache.conf.erb'),
  }
}
