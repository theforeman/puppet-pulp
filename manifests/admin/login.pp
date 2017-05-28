class pulp::admin::login (
  $username = $::pulp::admin::username,
  $password = $::pulp::admin::password,
  $id_cert_filename = $::pulp::admin::id_cert_filename,
) {
  if $password and $password != '' {
    exec { 'pulp-auth':
      command => "/usr/bin/pulp-admin login -u '${username}' -p '${password}'",
      creates => "/root/.pulp/${id_cert_filename}",
    }
  }
}
