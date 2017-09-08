# Sets up Apache for Crane
class pulp::crane::apache {

  include ::apache
  include ::apache::mod::headers
  include ::apache::mod::proxy
  include ::apache::mod::proxy_http
  include ::apache::mod::wsgi

  apache::vhost { 'crane':
    servername          => $::fqdn,
    docroot             => '/usr/share/crane/',
    wsgi_script_aliases => {
      '/' => '/usr/share/crane/crane.wsgi',
    },
    port                => $::pulp::crane::port,
    priority            => '03',
    ssl                 => true,
    ssl_cert            => $::pulp::crane::cert,
    ssl_key             => $::pulp::crane::key,
    ssl_chain           => $::pulp::crane::ca_cert,
    ssl_ca              => $::pulp::crane::ca_cert,
    ssl_verify_client   => 'optional',
    ssl_options         => '+StdEnvVars +ExportCertData +FakeBasicAuth',
    ssl_verify_depth    => '3',
    ssl_proxyengine     => true,
  }
}
