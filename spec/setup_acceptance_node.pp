if $facts['os']['name'] == 'CentOS' {
  package { 'epel-release':
    ensure => present,
  }
}
