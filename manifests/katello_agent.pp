#
# == Class: pulp::katello_agent
#
# Install and configure Pulp katello-agent
#
# === Parameters:
#
# $version::                       pulp katello-agent package version, it's passed to ensure parameter of package resource
#                                  can be set to specific version number, 'latest', 'present' etc.
#
#
# $cacert::                        The (optional) SSL CA certificate used to validate the server certificate.
#
#
# $clientcert::                    The (optional) SSL client certificate.  PEM encoded and contains both key and certificate.
#
#
class pulp::katello_agent (
  $version                   = $pulp::katello_agent::params::version,
  $cacert                    = $pulp::katello_agent::params::cacert,
  $clientcert                = $pulp::katello_agent::params::clientcert,
) inherits pulp::katello_agent::params {
  class { '::pulp::katello_agent::install': } ->
  class { '::pulp::katello_agent::config': } ~>
  class { '::pulp::katello_agent::service': }
}
