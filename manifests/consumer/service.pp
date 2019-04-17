# Pulp Consumer Service Packages
# @api private
class pulp::consumer::service {
  service { 'goferd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
