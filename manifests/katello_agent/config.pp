# Pulp Katello_agent Configuration
class pulp::katello_agent::config {
  file { '/etc/gofer/plugins/katelloplugin.conf':
    ensure  => 'file',
    content => template('pulp/katelloplugin.conf'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
