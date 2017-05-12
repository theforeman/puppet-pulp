# Pulp ostree plugin
#
# === Parameters:
#
# $package_ensure:: The state or version to install
# $ssl_verify_client:: SSL client connection verification
# $proxy_host:: Host of the proxy server.
# $proxy_port:: Port the proxy is running on.
# $proxy_username:: Proxy username for authentication.
# $proxy_password:: Proxy password for authentication.
class pulp::plugin::ostree (
  $package_ensure = undef,
  # Vars in https.conf.erb
  Enum['none', 'optional', 'require', 'optional_no_ca'] $ssl_verify_client = $::pulp::ssl_verify_client,
  # Vars in ostree_importer
  Optional[String] $proxy_host = $::pulp::proxy_url,
  Optional[Integer[1, 65535]] $proxy_port = $::pulp::proxy_port,
  Optional[String] $proxy_username = $::pulp::proxy_username,
  Optional[String] $proxy_password = $::pulp::proxy_password,
) {
  ensure_packages(['ostree'])

  pulp::plugin { 'ostree':
    package_ensure => $package_ensure,
    configs        => {'ostree_importer' => template('pulp/plugins/ostree/ostree_importer.json.erb')},
    apache_config  => template('pulp/plugins/ostree/apache.conf.erb'),
    require        => Package['ostree'],
  }
}
