# RPM pulp plugin
#
# === Parameters:
#
# $package_ensure:: The state or version to install
# $ssl_verify_client:: SSL client connection verification
# $proxy_host:: Host of the proxy server.
# $proxy_port:: Port the proxy is running on.
# $proxy_username:: Proxy username for authentication.
# $proxy_password:: Proxy password for authentication.
# $yum_max_speed:: The maximum download speed for a Pulp task, such as a sync in bytes/s.
class pulp::plugin::rpm (
  $package_ensure = undef,
  # Vars in apache.conf.erb
  Enum['none', 'optional', 'require', 'optional_no_ca'] $ssl_verify_client = $::pulp::ssl_verify_client,
  # Vars in yum_importer.json.erb,iso_importer.json.erb and yum_importer.json.erb
  Optional[String] $proxy_host = $::pulp::proxy_url,
  Optional[Integer[1, 65535]] $proxy_port = $::pulp::proxy_port,
  Optional[String] $proxy_username = $::pulp::proxy_username,
  Optional[String] $proxy_password = $::pulp::proxy_password,
  # Vars in yum_importer.json.erb
  Optional[Integer] $yum_max_speed = $::pulp::yum_max_speed,
) {
  pulp::plugin { 'rpm':
    package_ensure => $package_ensure,
    configs        => {
      'iso_importer' => template('pulp/plugins/rpm/iso_importer.json.erb'),
      'yum_importer' => template('pulp/plugins/rpm/yum_importer.json.erb'),
    },
    http_config    => file('pulp/plugins/rpm/http.conf'),
    apache_config  => template('pulp/plugins/rpm/apache.conf.erb'),
  }
}
