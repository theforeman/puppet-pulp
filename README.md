####Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with pulp](#setup)
    * [What pulp affects](#what-pulp-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with pulp](#beginning-with-pulp)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This module is designed to setup a Pulp master or node.

##Setup

###What pulp affects

* Installs and configures a Pulp master or node

###Beginning with pulp

The very basic steps needed for a user to get the module up and running. 

If your most recent release breaks compatibility or requires particular steps for upgrading, you may wish to include an additional section here: Upgrading (For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

##Usage

###Qpid and ssl using puppet certificates

      $ca_cert = '/etc/pki/pulp/qpid/ca.pem'
      $cert = '/etc/pki/pulp/qpid/client.pem'
    
      file { $ca_cert:
        source => "${::settings::ssldir}/certs/ca.pem",
        owner  => 'root',
        group  => 'apache',
        mode   => '0640',
      } ~> Class['pulp::service']
    
      concat { $cert:
        ensure => present,
        owner  => 'root',
        group  => 'apache',
        mode   => '0640',
      } ~> Class['pulp::service']
    
      concat::fragment { 'public_cert':
        target => $cert,
        source => "${::settings::ssldir}/certs/${::clientcert}.pem",
        order  => '01'
      }
    
      concat::fragment { 'private_cert':
        target => $cert,
        source => "${::settings::ssldir}/private_keys/${::clientcert}.pem",
        order  => '02'
      }
    
      nssdb::create { 'qpidd':
        owner_id => 'qpidd',
        group_id => 'qpidd',
        password => 'test_pass',
        cacert   => "${::settings::ssldir}/certs/ca.pem",
        basedir  => '/etc/pki/pulp/qpid/nss',
      } ->
      nssdb::add_cert_and_key { 'qpidd':
        nickname => 'broker',
        cert     => "${::settings::ssldir}/certs/${::clientcert}.pem",
        key      => "${::settings::ssldir}/private_keys/${::clientcert}.pem",
        basedir  => '/etc/pki/pulp/qpid/nss'
      }
    
      class { 'qpid':
        ssl                    => true,
        ssl_cert_db            => '/etc/pki/pulp/qpid/nss/qpidd',
        ssl_cert_password_file => '/etc/pki/pulp/qpid/nss/qpidd/password.conf',
        ssl_cert_name          => 'broker',
        user_groups            => [],
      }
    
      class { 'pulp':
        messaging_url         => "ssl://${::fqdn}:5671",
        messaging_ca_cert     => $ca_cert,
        messaging_client_cert => $cert,
        broker_url            => "qpid://${::fqdn}:5671",
        broker_use_ssl        => true,
      }
    
      class { 'pulp::consumer':
        messaging_scheme     => 'ssl',
        messaging_host       => $::fqdn,
        messaging_port       => 5671,
        messaging_cacert     => $ca_cert,
        messaging_clientcert => $cert,
      }

##Reference

##Limitations

* EL6,7 (RHEL6,7 / CentOS 6,7)

##Pulp consumer

###Installation:

    include pulp::consumer

###Register consumer:
The provider doesn't support yet updating notes or description.

    pulp_register{$::fqdn:
    	user => 'admin',
    	pass => 'admin'
    }

##Development

See the CONTRIBUTING guide for steps on how to make a change and get it accepted upstream.

