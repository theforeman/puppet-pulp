require 'puppet/property/boolean'
# curl -E ~/.pulp/user-cert.pem "https://$(hostname)/pulp/api/v2/repositories/epel_el6/?details=True" | python -mjson.tool

Puppet::Type.newtype(:pulp_isorepo) do
  @doc = <<-EOT
    doc 
  EOT

  autorequire(:file) do
    [
      self[:conf_file],
      self[:feed_ca_cert],
      self[:feed_cert],
      self[:feed_key],
    ]
  end

  ensurable do
    desc <<-EOS
      Create/Remove pulp iso repo.
    EOS

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end

    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc "repo-id: uniquely identifies the rpm repo"
  end

  newparam(:conf_file, :parent => Puppet::Parameter::Path) do
    desc "path to pulp-admin's config file. Defaults to /etc/pulp/admin/admin.conf"
    defaultto('/etc/pulp/admin/admin.conf')
  end

  newproperty(:display_name) do
    desc "user-readable display name (may contain i18n characters)"
    defaultto do
      @resource[:name]
    end
  end

  newproperty(:description) do
    desc "user-readable description (may contain i18n characters)"
  end

  newproperty(:note) do
    desc "adds/updates/deletes notes to programmatically identify the resource"
    validate do |value|
      raise ArgumentError, "Note property should be a hash" unless value.kind_of?(Hash)
    end
  end

  newproperty(:feed) do
    desc "URL of the external source repository to sync"
  end

  newproperty(:validate, :boolean => true, :parent => Puppet::Property::Boolean) do
    desc 'if "true", the size and checksum of each synchronized file will
    be verified against the repo metadata'
    defaultto :false
  end

  newproperty(:feed_ca_cert) do
    desc "full path to the CA certificate that should be used to
    verify the external repo server's SSL certificate"
  end

  newproperty(:verify_feed_ssl, :boolean => true, :parent => Puppet::Property::Boolean) do
    desc 'if "true", the feed\'s SSL certificate will be verified
    against the feed_ca_cert'
    defaultto :false
  end

  newproperty(:feed_cert) do
    desc "full path to the certificate to use for authorization when accessing the external feed"
  end

  newproperty(:feed_key) do
    desc "full path to the private key for feed_cert"
  end

  newproperty(:proxy_host) do
    desc "proxy server url to use"
  end

  newproperty(:proxy_port) do
    desc "port on the proxy server to make requests"
    newvalues(/^\d+$/)
    munge do |value|
      Integer(value)
    end
  end

  newproperty(:proxy_user) do
    desc "username used to authenticate with the proxy server"
  end

  newproperty(:proxy_pass) do
    desc "password used to authenticate with the proxy server"
  end

  newproperty(:max_downloads) do
    desc "maximum number of downloads that will run concurrently"
    newvalues(/^\d+$/)
    munge do |value|
      Integer(value)
    end
  end

  newproperty(:max_speed) do
    desc "maximum bandwidth used per download thread, in bytes/sec,
    when synchronizing the repo"
    newvalues(/^\d+$/)
    munge do |value|
      Integer(value)
    end
  end

  newproperty(:remove_missing, :boolean => true, :parent => Puppet::Property::Boolean) do
    desc 'if "true", units that were previously in the external
    feed but are no longer found will be removed from the  repository'
    defaultto :false
  end

  newproperty(:serve_http, :boolean => true, :parent => Puppet::Property::Boolean) do
    desc 'if "true", the repository will be served over HTTP'
    defaultto :false
  end

  newproperty(:serve_https, :boolean => true, :parent => Puppet::Property::Boolean) do
    desc 'if "true", the repository will be served over HTTPS'
    defaultto :true
  end
end
