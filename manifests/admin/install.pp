# Pulp Admin Install Packages
# @api private
class pulp::admin::install {
  package { 'pulp-admin-client':
    ensure => $pulp::admin::version,
  }

  if $pulp::admin::enable_puppet {
    # https://bugzilla.redhat.com/show_bug.cgi?id=1105673
    package { ['pulp-puppet-admin-extensions', 'pulp-puppet-tools', 'python-pulp-puppet-common']:
      ensure => $pulp::admin::version,
    }
  }

  if $pulp::admin::enable_deb {
    package { 'pulp-deb-admin-extensions':
      ensure => $pulp::admin::version,
    }
  }

  if $pulp::admin::enable_docker {
    package { 'pulp-docker-admin-extensions':
      ensure => $pulp::admin::version,
    }
  }

  if $pulp::admin::enable_nodes {
    package { 'pulp-nodes-admin-extensions':
      ensure => $pulp::admin::version,
    }
  }

  if $pulp::admin::enable_python {
    package { 'pulp-python-admin-extensions':
      ensure => $pulp::admin::version,
    }
  }

  if $pulp::admin::enable_ostree {
    package { 'pulp-ostree-admin-extensions':
      ensure => $pulp::admin::version,
    }
  }

  if $pulp::admin::enable_rpm or $pulp::admin::enable_iso {
    package { 'pulp-rpm-admin-extensions':
      ensure => $pulp::admin::version,
    }
  }
}
