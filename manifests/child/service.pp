# Pulp Node Service
class pulp::child::service(
  $service = 'goferd',
  $ensure = 'running',
  $enable = true,
) {
  service { $service:
    ensure => $ensure,
    enable => $enable,
  }
}
