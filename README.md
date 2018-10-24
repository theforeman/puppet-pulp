[![Puppet Forge](https://img.shields.io/puppetforge/v/katello/pulp.svg)](https://forge.puppetlabs.com/katello/pulp)
[![Build Status](https://travis-ci.org/theforeman/puppet-pulp.svg?branch=master)](https://travis-ci.org/theforeman/puppet-pulp)
[![puppetmodule.info docs](http://www.puppetmodule.info/images/badge.png)](http://www.puppetmodule.info/m/katello-pulp)

#### Table of Contents

1. [Overview](#overview)
2. [Usage - The basics of getting started with pulp](#pulp)
    * [Installation](#installation)
    * [Security and external services](#security-and-external-services)
    * [RPM provider](#rpm-provider)
    * [Puppet provider](#puppet-provider)
    * [ISO provider](#iso-provider)
    * [Schedule provider](#schedule-provider)
    * [Pulp admin](#pulp-admin)
    * [Pulp child](#pulp-child)
    * [Pulp consumer](#pulp-consumer)
    * [Pulp Crane](#pulp-crane)
3. [Development - Guide for contributing to the module](#development)

## Overview

This module can be used to install and manage several aspects of a pulp installation.

### Pulp

#### Installation

The main pulp server installation. This includes the Apache configuration and the various daemons.

```puppet
include ::pulp
```

Note that you need EPEL and a Pulp repository. For this we recommend [stahnma/epel](https://forge.puppet.com/stahnma/epel) and use of the ```pulp::repo::upstream``` class.

```puppet
include ::epel
include ::pulp::repo::upstream
class { '::pulp':
  require => Class['epel', 'pulp::repo::upstream'],
}
```

Plugins can be enabled as well:

```puppet
class { '::pulp':
  enable_docker => true,
  enable_ostree => true,
  enable_puppet => true,
  enable_python => true,
  enable_rpm    => true,
}
```

By default a user admin will be created with a randomized password. This is configurable with the ```default_login``` and ```default_password``` parameters:

```puppet
class { '::pulp':
  default_login    => 'user',
  default_password => 'secret',
}
```

#### Security and external services

By default the MongoDB database is managed, but the ```manage_db``` parameter can be used to change this behaviour.

Likewise the broker is managed by default, but ```manage_broker``` is there. The implementation can be switched from the default ```qpid``` to ```rabbitmq```.

There are various types that can be used to manage providers, assuming the correct plugin is installed.

For security certificates can be used. For example on the webservice:

```puppet
class { '::pulp':
  https_cert   => '/path/to/public_key.pem',
  https_key    => '/path/to/private_key.pem',
  https_chain  => '/path/to/ca_chain.pem',
  # Optionally you can change the accepted protocols
  ssl_protocol => ['all', '-SSLv3', '-TLSv1', '-TLSv1.1'],
}
```

The connection to the MongoDB server can also be encrypted:

```puppet
class { '::pulp':
  db_ssl          => true,
  db_ssl_keyfile  => '/path/to/private_key.pem',
  db_ssl_certfile => '/path/to/public_key.pem',
  db_ca_path      => '/path/to/ca.pem',
}
```

Similarly the connection to the message broker can be encrypted:

```puppet
class { '::pulp':
  broker_url     => 'qpid://user:password@broker.example.com:5671',
  broker_use_ssl => true,
}
```

The email behaviour is configurable as well:

```puppet
class { '::pulp':
  email_host    => 'localhost',
  email_port    => 25,
  email_from    => 'admin@example.com',
  email_enabled => true,
}
```

In case you need to connect through a proxy you can specify the host, port, username and password. Note the ```proxy_url``` parameter actually maps to the ```proxy_host``` parameter in the configs.

```puppet
class { '::pulp':
  proxy_url      => 'proxy.example.com',
  proxy_port     => 80,
  proxy_username => 'user',
  proxy_password => 'secret',
}
```

#### RPM provider

```puppet
pulp_rpmrepo { 'scl_ruby22_el7':
  checksum_type    => 'sha256',
  display_name     => 'scl_ruby22_el7',
  feed             => 'https://www.softwarecollections.org/repos/rhscl/rh-ruby22/epel-7-x86_64/',
  relative_url     => 'scl_ruby22/7Server',
  remove_missing   => true,
  retain_old_count => 1,
  serve_http       => true,
  serve_https      => true,
  validate         => true,
}
```

#### Puppet provider

```puppet
pulp_puppetrepo { 'company_puppet_forge':
  display_name    => 'company_puppet_forge',
  max_downloads   => 10,
  serve_http      => true,
  serve_https     => true,
  validate        => true,
  verify_feed_ssl => false,
}
```

#### ISO provider

```puppet
pulp_isorepo { 'optymyze_thirdparty':
  display_name    => 'files_thirdparty',
  feed            => 'https://pulp-server.company.net/pulp/isos/files_thirdparty/',
  max_downloads   => 10,
  remove_missing  => false,
  serve_http      => true,
  serve_https     => true,
  validate        => true,
  verify_feed_ssl => false,
}
```

#### Schedule provider

```puppet
pulp_schedule { 'scl_ruby22_el7':
  enabled       => 'true',
  schedule_time => '2000-W01-6T12:00Z/P1W',
}

# force schedules to be added after the repos are created
Pulp_rpmrepo <| |> -> Pulp_schedule <| |>
```

### Pulp admin

The easiest is to use ```enable_admin``` parameter. This ensures all plugins have their admin component installed as well as configuring the client to talk to the server using the ```default_login``` and ```default_password``` parameters.

```puppet
class { 'pulp':
  enable_admin => true,
}
```

On standalone machines it is also possible to only install the admin utility by directly using ```pulp::admin```:

```puppet
include ::pulp::admin
```

In this case plugins need to be managed explicitly.

```puppet
class { '::pulp::admin':
  enable_docker => true,
  enable_ostree => true,
  enable_puppet => true,
  enable_python => true,
  enable_nodes  => true
  enable_rpm    => true,
}
```

### Pulp Child

Manage a pulp child installation.

```puppet
include ::pulp::child
```

### Pulp consumer

Manage pulp consumers.

#### Installation

```puppet
include ::pulp::consumer
```

#### Register consumer

```puppet
pulp_register { $::fqdn:
  user => 'admin',
  pass => 'admin',
}
```

### Pulp Crane

Manage pulp crane, a minimal docker registry.

You can either deploy it standalone:

```puppet
include ::pulp::crane
```

Or as part of a full Pulp installation:

```puppet
class { '::pulp':
  enable_crane => true,
}
```

### Role provider

```puppet
pulp_role { 'repo_admin':
  ensure      => 'present',
  users       => ['alice', 'bob'],
  permissions => {'/' => ['READ', 'CREATE'], '/v2/repositories/scl_ruby22_el7/' => ['READ', 'EXECUTE', 'UPDATE', 'CREATE', 'DELETE']},
}
```

## Development

See the CONTRIBUTING guide for steps on how to make a change and get it accepted upstream.
