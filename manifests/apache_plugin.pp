# Define a the Apache config for a plugin
# @api private
define pulp::apache_plugin ($confd = true, $vhosts80 = true) {
  include apache

  if $confd {
    file { "${apache::confd_dir}/pulp_${name}.conf":
      ensure  => file,
      content => template("pulp/etc/httpd/conf.d/pulp_${name}.conf.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Service['httpd'],
    }
  }

  if $vhosts80 {
    file { "${apache::confd_dir}/pulp-vhosts80/${name}.conf":
      ensure  => file,
      content => template("pulp/vhosts80/${name}.conf"),
      owner   => 'apache',
      group   => 'apache',
      mode    => '0600',
      notify  => Service['httpd'],
    }
  }
}
