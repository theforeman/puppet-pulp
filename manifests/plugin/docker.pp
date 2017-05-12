# Docker pulp plugin
#
# === Parameters:
#
# $package_ensure:: The state or version to install
# $proxy_host:: Host of the proxy server
# $proxy_port:: Port the proxy is running on
# $proxy_username:: Proxy username for authentication
# $proxy_password:: Proxy password for authentication
class pulp::plugin::docker (
  $package_ensure = undef,
  # Vars in config
  Optional[String] $proxy_host = $::pulp::proxy_url,
  Optional[Integer[1, 65535]] $proxy_port = $::pulp::proxy_port,
  Optional[String] $proxy_username = $::pulp::proxy_username,
  Optional[String] $proxy_password = $::pulp::proxy_password,
) {
  include ::apache::mod::headers

  pulp::plugin { 'docker':
    package_ensure => $package_ensure,
    configs        => {'docker_importer' => template('pulp/plugins/docker/docker_importer.json.erb')},
    apache_config  => file('pulp/plugins/docker/apache.conf'),
  }
}
