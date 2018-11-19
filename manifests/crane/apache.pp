# Sets up Apache for Crane
class pulp::crane::apache {

  include apache
  include apache::mod::headers
  include apache::mod::proxy
  include apache::mod::proxy_http
  include apache::mod::wsgi

  # For backwards compatiblity, we still need to default ssl_chain to ca_cert...
  $ssl_chain = pick($pulp::crane::ssl_chain, $pulp::crane::ca_cert)

  apache::vhost { 'crane':
    servername          => $facts['fqdn'],
    docroot             => '/usr/share/crane/',
    wsgi_script_aliases => {
      '/' => '/usr/share/crane/crane.wsgi',
    },
    port                => $pulp::crane::port,
    priority            => '03',
    ssl                 => true,
    ssl_cert            => $pulp::crane::cert,
    ssl_key             => $pulp::crane::key,
    ssl_chain           => $ssl_chain,
    ssl_ca              => $pulp::crane::ca_cert,
    ssl_certs_dir       => '',
    ssl_verify_client   => 'optional',
    ssl_options         => '+StdEnvVars +ExportCertData +FakeBasicAuth',
    ssl_protocol        => $pulp::crane::ssl_protocol,
    ssl_verify_depth    => '3',
    ssl_proxyengine     => true,
  }
}
