# The class to manage squid. This is used by pulp streamer.
# @api private
class pulp::squid(
  Stdlib::Port $port = 3128,
  Stdlib::Host $streamer_host = '127.0.0.1',
  Stdlib::Port $streamer_port = 8751,
  String $maximum_object_size = '5 GB',
  String $maximum_object_size_in_memory = '100 MB',
  Stdlib::Absolutepath $cache_dir = '/var/spool/squid',
) {
  class { 'squid':
    maximum_object_size_in_memory => $maximum_object_size_in_memory,
  }

  squid::acl { 'Safe_ports':
    type    => 'port',
    entries => [$port],
  }

  squid::http_port { 'pulp internal port':
    port    => $port,
    options => "accel defaultsite=${streamer_host}:${streamer_port}",
  }

  squid::http_access { 'localhost':
    action => 'allow',
  }

  squid::http_access { 'to_localhost':
    action => 'deny',
  }

  squid::http_access { 'all':
    action => 'deny',
  }

  squid::cache { 'all':
    action => 'allow',
  }

  squid::cache_dir { $cache_dir:
    type    => 'aufs',
    options => '10000 16 256',
  }

  squid::extra_config_section { 'extra settings':
    order          => '60',
    config_entries => {
      'cache_peer'          => "${streamer_host} parent ${streamer_port} 0 no-digest no-query originserver name=PulpStreamer",
      'cache_peer_access'   => 'PulpStreamer allow all',
      'range_offset_limit'  => 'none',
      'maximum_object_size' => $maximum_object_size,
      'minimum_object_size' => '0 kB',
    },
  }
}
