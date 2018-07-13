# The class to manage squid. This is used by pulp streamer.
class pulp::squid(
  Integer $port = 3128,
  String $maximum_object_size = '5 GB',
  String $maximum_object_size_in_memory = '100 MB',
) {
  class { '::squid3':
    use_deprecated_opts           => false,
    http_port                     => [ "${port} accel defaultsite=127.0.0.1:8751" ],
    acl                           => [ "Safe_ports port ${port}" ],
    http_access                   => [ 'allow localhost', 'deny to_localhost', 'deny all' ],
    cache                         => [ 'allow all' ],
    maximum_object_size           => $maximum_object_size,
    maximum_object_size_in_memory => $maximum_object_size_in_memory,
    cache_dir                     => [ 'aufs /var/spool/squid 10000 16 256' ],
    template                      => 'short',
    config_hash                   => {
      cache_peer          => '127.0.0.1 parent 8751 0 no-digest no-query originserver name=PulpStreamer',
      cache_peer_access   => 'PulpStreamer allow all',
      range_offset_limit  => 'none',
      minimum_object_size => '0 kB',
    },
  }
}
