# Set up the broker
class pulp::broker {
  if $pulp::messaging_transport == 'qpid' {
    $broker_service = 'qpidd'
  } elsif $pulp::messaging_transport == 'rabbitmq' {
    $broker_service = 'rabbitmq-server'
  }

  if $pulp::manage_broker {
    if $pulp::messaging_transport == 'qpid' {
      include ::qpid
    } elsif $pulp::messaging_transport == 'rabbitmq' {
      include ::rabbitmq
    }
  } else {
    if $pulp::messaging_transport == 'qpid' {
      include ::qpid::tools

      Class['qpid::tools'] -> Class['pulp::service']
    }
  }

  Service <| title == $broker_service |> -> Class['pulp::service']
  Service <| title == $broker_service |> -> Exec['migrate_pulp_db']
}
