# Sets up Apache for Crane
class pulp::crane::apache {

  include ::apache
  include ::apache::mod::headers
  include ::apache::mod::proxy
  include ::apache::mod::proxy_http

  apache::vhost { 'crane':
    servername          => $pulp::crane::fqdn,
    docroot             => '/usr/share/crane/',
    wsgi_script_aliases =>
                          {
                            '/' => '/usr/share/crane/crane.wsgi',
                          },
    port                => $pulp::crane::port,
    priority            => '03',
    ssl                 => true,
    ssl_cert            => $pulp::https_cert,
    ssl_key             => $pulp::https_key,
    ssl_chain           => $pulp::https_chain,
    ssl_ca              => $pulp::ca_cert,
    ssl_verify_client   => 'optional',
    ssl_options         => '+StdEnvVars +ExportCertData +FakeBasicAuth',
    ssl_verify_depth    => '3',
    ssl_proxyengine     => true,
  }
}
