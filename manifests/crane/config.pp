# Configure Crane
class pulp::crane::config {
  file { '/etc/crane.conf':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('pulp/crane.conf.erb'),
  }
}
