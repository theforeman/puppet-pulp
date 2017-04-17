# Pulp Katello_agent Params
class pulp::katello_agent::params {
  $version = 'installed'
  $cacert = '/etc/rhsm/ca/candlepin-local.pem'
  $clientcert = '/etc/pki/consumer/bundle.pem'
}
