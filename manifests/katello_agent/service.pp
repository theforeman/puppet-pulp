# Pulp Katello_agent Service Packages
class pulp::katello_agent::service {
  service { 'goferd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
