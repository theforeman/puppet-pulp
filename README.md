[![Puppet Forge](http://img.shields.io/puppetforge/v/katello/pulp.svg)](https://forge.puppetlabs.com/katello/pulp)
[![Build Status](https://travis-ci.org/Katello/puppet-pulp.svg?branch=master)](https://travis-ci.org/Katello/puppet-pulp)
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

##Reference

##Limitations

* EL6,7 (RHEL6,7 / CentOS 6,7)
* Requires Pulp 2.7.0 or higher.
* Database authentication parameters are ignored when running MongoDB older than 2.6

##Pulp consumer

###Installation:

    include pulp::consumer

###Register consumer:
The provider doesn't support yet updating notes or description.

    pulp_register{$::fqdn:
    	user => 'admin',
    	pass => 'admin'
    }

##Pulp providers

### RPM provider

	pulp_rpmrepo { 'scl_ruby22_el7':
	  checksum_type    => 'sha256',
	  display_name     => 'scl_ruby22_el7',
	  feed             => 'https://www.softwarecollections.org/repos/rhscl/rh-ruby22/epel-7-x86_64/',
	  relative_url     => 'scl_ruby22/7Server',
	  remove_missing   => 'true',
	  retain_old_count => '1',
	  serve_http       => 'true',
	  serve_https      => 'true',
	  validate         => 'true',
	}

### Puppet provider

	pulp_puppetrepo { 'company_puppet_forge':
	  display_name    => 'company_puppet_forge',
	  max_downloads   => '10',
	  serve_http      => 'true',
	  serve_https     => 'true',
	  validate        => 'true',
	  verify_feed_ssl => 'false',
	}

### ISO provider

	pulp_isorepo { 'optymyze_thirdparty':
	  display_name    => 'files_thirdparty',
	  feed            => 'https://pulp-server.company.net/pulp/isos/files_thirdparty/',
	  max_downloads   => '10',
	  remove_missing  => 'false',
	  serve_http      => 'true',
	  serve_https     => 'true',
	  validate        => 'true',
	  verify_feed_ssl => 'false',
	}

### Schedule provider

	pulp_schedule { 'scl_ruby22_el7':
	  enabled       => 'true',
	  schedule_time => '2000-W01-6T12:00Z/P1W',
	}

	# force schedules to be added after the repos are created
	Pulp_rpmrepo <| |> -> Pulp_schedule <| |>

##Development

See the CONTRIBUTING guide for steps on how to make a change and get it accepted upstream.
