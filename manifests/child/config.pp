# Pulp Node Configuration
class pulp::child::config(
  $servername = $::fqdn,
  $ssl_cert = $::pulp::child::ssl_cert,
  $ssl_key = $::pulp::child::ssl_key,
  $ssl_ca = $::pulp::ca_cert,
  $max_keep_alive = $::pulp::max_keep_alive,
  $ssl_username = $::pulp::ssl_username,
) {

  file { '/etc/pulp/nodes.conf':
    ensure  => 'file',
    content => template('pulp/nodes.conf.erb'),
  }

  include ::apache

  if $ssl_username and !empty($ssl_username) {
    $directories = {
      'path'            => '/pulp/api',
      'provider'        => 'Location',
      'custom_fragment' => "SSLUsername ${ssl_username}",
    }
  } else {
    $directories = undef
  }

  apache::vhost { 'pulp-node-ssl':
    servername             => $servername,
    docroot                => '/var/www/html',
    port                   => 443,
    priority               => '25',
    keepalive              => 'on',
    max_keepalive_requests => $max_keep_alive,
    directories            => $directories,
    ssl                    => true,
    ssl_cert               => $ssl_cert,
    ssl_key                => $ssl_key,
    ssl_ca                 => $ssl_ca,
    ssl_verify_client      => 'optional',
    ssl_options            => '+StdEnvVars',
    ssl_verify_depth       => '3',
    # allow older yum clients to connect, see bz 647828
    custom_fragment        => 'SSLInsecureRenegotiation On',
  }

  # we need to make sure the goferd reads the current oauth credentials to talk
  # to the child node
  File['/etc/pulp/server.conf'] ~> Service['goferd']
}
