# Pulp plugin configuration
#
# @param content The content
# @param filename The filename
# @param show_diff Allow config showing diff. May display and log passwords.
define pulp::config::plugin (
  String $content,
  String $filename = "/etc/pulp/server/plugins.conf.d/${title}.json",
  Boolean $show_diff = $::pulp::show_conf_diff,
) {
  if $content {
    file { $filename:
      ensure    => file,
      content   => $content,
      owner     => 'root',
      group     => 'root',
      mode      => '0644',
      show_diff => $show_diff,
      require   => Class['pulp::config'],
      before    => Class['pulp::database'],
    }
  } else {
    file { $filename:
      ensure => absent,
      before => Class['pulp::database'],
    }
  }
}
