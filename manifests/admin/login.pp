# Ensure the user is logged in to execute commands
# @api private
class pulp::admin::login (
  $login_method = $pulp::admin::login_method,
  $username = $pulp::admin::username,
  $password = $pulp::admin::password,
  $id_cert_filename = $pulp::admin::id_cert_filename,
) {
  file { '/root/.pulp':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }

  case $login_method {
    'file': {
      file { '/root/.pulp/admin.conf':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        content => template('pulp/admin_home.conf.erb'),
      }
    }
    'login': {
      exec { 'pulp-auth':
        command => "/usr/bin/pulp-admin login -u '${username}' -p '${password}'",
        creates => "/root/.pulp/${id_cert_filename}",
        require => File['/root/.pulp'],
      }
    }
    default: {}
  }
}
