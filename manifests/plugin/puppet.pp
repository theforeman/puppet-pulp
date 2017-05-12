# Pulp puppet plugin
#
# === Parameters:
#
# $package_ensure:: The state or version to install
# $proxy_host:: Host of the proxy server.
# $proxy_port:: Port the proxy is running on.
# $proxy_username:: Proxy username for authentication.
# $proxy_password:: Proxy password for authentication.
# $wsgi_processes:: Number of WSGI processes to spawn for the puppet webapp
class pulp::plugin::puppet (
  $package_ensure = undef,
  # Used in puppet_importer.json.erb
  Optional[String] $proxy_host = $::pulp::proxy_url,
  Optional[Integer[1, 65535]] $proxy_port = $::pulp::proxy_port,
  Optional[String] $proxy_username = $::pulp::proxy_username,
  Optional[String] $proxy_password = $::pulp::proxy_password,
  # Used in apache.conf.erb
  Integer $wsgi_processes = $::pulp::puppet_wsgi_processes,
) {
  pulp::plugin { 'puppet':
    package_ensure => $package_ensure,
    configs        => {'puppet_importer' => template('pulp/plugins/puppet/puppet_importer.json.erb')},
    http_config    => file('pulp/plugins/puppet/http.conf'),
    apache_config  => template('pulp/plugins/puppet/apache.conf.erb'),
  }

  if $::selinux == 'true' {  # lint:ignore:quoted_booleans
    selboolean { 'pulp_manage_puppet':
      value      => 'on',
      persistent => true,
      require    => Pulp::Plugin['puppet'],
    }
  }
}
