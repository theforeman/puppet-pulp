# Set up the messaging broker
class pulp::broker {
  if $pulp::broker_manage {
    if $pulp::messaging_transport == 'qpid' {
      include ::qpid
      Class['qpid'] -> Class['pulp::install']
    }
  }
}
