class pulp::mod_wsgi {

  $mod_path = $facts['operatingsystemmajrelease'] ? {
    '8' => 'mod_wsgi_python3.so',
    default => 'mod_wsgi.so'
  }

  class { 'apache::mod::wsgi':
    package_name => 'mod_wsgi',
    mod_path     => $mod_path
  }

}
