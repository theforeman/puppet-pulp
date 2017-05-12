# A pulp plugin
#
# @param package_name The package name to install
# @param package_ensure The state or version to install
# @param configs A hash of config files to install. Each key is the filename and the value the content. Uses pulp::config::plugin.
# @param manage_http Whether to manage apache files
# @param http_config The optional config for the HTTP vhost. Ignored if manage_http is false.
# @param apache_config An optional global apache config snippet. Ignored if manage_http is false.
define pulp::plugin (
  $package_name = undef,
  $package_ensure = undef,
  Hash[String, String] $configs = {},
  Boolean $manage_http = $::pulp::manage_plugin_http,
  $http_config = undef,
  $apache_config = undef,
) {
  pulp::install::plugin { $name:
    package_name   => $package_name,
    package_ensure => $package_ensure,
  }

  $configs.each |$filename, $content| {
    pulp::config::plugin { $filename:
      content => $content,
    }
  }

  if $manage_http {
    pulp::apache::plugin { $name:
      http_config   => $http_config,
      global_config => $apache_config,
    }
  }
}
