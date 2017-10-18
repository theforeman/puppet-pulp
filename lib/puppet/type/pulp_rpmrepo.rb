require 'puppet/property/boolean'
# curl -E ~/.pulp/user-cert.pem "https://$(hostname)/pulp/api/v2/repositories/epel_el6/?details=True" | python -mjson.tool

Puppet::Type.newtype(:pulp_rpmrepo) do
  @doc = <<-EOT
    doc 
  EOT

  autorequire(:file) do
    [
      self[:conf_file],
      self[:feed_ca_cert],
      self[:feed_cert],
      self[:feed_key],
      self[:host_ca],
      self[:auth_ca],
      self[:auth_cert],
    ]
  end

  ensurable do
    desc <<-EOS
      Create/Remove pulp rpm repo.
    EOS

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end

    defaultto :present
  end

  def munge_boolean_to_symbol(value)
    # insync? doesn't work with actual booleans
    # see https://tickets.puppetlabs.com/browse/PUP-2368
    value = value.downcase if value.respond_to? :downcase

    case value
    when true, :true, 'true', :yes, 'yes'
      :true
    when false, :false, 'false', :no, 'no'
      :false
    else
      raise ArgumentError, 'expected a boolean value'
    end
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
  end

  newproperty(:description) do
    desc "user-readable description (may contain i18n characters)"
  end

  newproperty(:note) do
    desc "adds/updates/deletes notes to programmatically identify the  resource"
    validate do |value|
      raise ArgumentError, "Note property should be a hash" unless value.kind_of?(Hash)
    end
  end

  newproperty(:feed) do
    desc "URL of the external source repository to sync"
  end

  newproperty(:validate) do
    desc 'if "true", the size and checksum of each synchronized file will
    be verified against the repo metadata'

    munge { |value| @resource.munge_boolean_to_symbol(value) }
  end

  newproperty(:skip, :array_matching => :all) do
    desc "comma-separated list of types to omit when synchronizing, if not
    specified all types will be synchronized; valid values are: rpm,
    drpm, distribution, erratum"
    newvalues(:rpm, :drpm, :distribution, :erratum)
  end

  newproperty(:feed_ca_cert) do
    desc "full path to the CA certificate that should be used to
    verify the external repo server's SSL certificate"
  end

  newproperty(:verify_feed_ssl) do
    desc 'if "true", the feed\'s SSL certificate will be verified against the feed_ca_cert'

    munge { |value| @resource.munge_boolean_to_symbol(value) }
  end

  newproperty(:feed_cert) do
    desc "full path to the certificate to use for authorization when
    accessing the external feed"
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

  newproperty(:remove_missing) do
    desc 'if "true", units that were previously in the external
    feed but are no longer found will be removed from the repository'

    munge { |value| @resource.munge_boolean_to_symbol(value) }
  end

  newproperty(:retain_old_count) do
    desc "count indicating how many non-latest versions of a unit
    to keep in a repository"
    newvalues(/^\d+$/)
    munge do |value|
      Integer(value)
    end
  end

  newproperty(:relative_url) do
    desc "relative path the repository will be served from. Only
    alphanumeric characters, forward slashes, underscores and
    dashes are allowed."
  end

  newproperty(:serve_http) do
    desc 'if "true", the repository will be served over HTTP'

    munge { |value| @resource.munge_boolean_to_symbol(value) }
  end

  newproperty(:serve_https) do
    desc 'if "true", the repository will be served over HTTPS'

    munge { |value| @resource.munge_boolean_to_symbol(value) }
  end

  newproperty(:checksum_type) do
    desc "type of checksum to use during metadata generation"
  end

  newproperty(:gpg_key) do
    desc "GPG key used to sign and verify packages in the repository"
  end

  newproperty(:generate_sqlite) do
    desc 'if "true", sqlite files will be generated for the repository metadata during publish'

    munge { |value| @resource.munge_boolean_to_symbol(value) }
  end

  newproperty(:host_ca) do
    desc "full path to the CA certificate that signed the repository
    hosts's SSL certificate when serving over HTTPS"
  end

  newproperty(:auth_ca) do
    desc "full path to the CA certificate that should be used to verify
    client authentication certificates; setting this turns on client
    authentication for the repository"
  end

  newproperty(:auth_cert) do
    desc "full path to the entitlement certificate that will be given to
    bound consumers to grant access to this repository"
  end

  newproperty(:updateinfo_checksum_type) do
    desc "type of checksum to use during updateinfo.xml generation"
  end

  newproperty(:repoview) do
    desc 'if "true", static HTML files will be generated
    during publish by the repoview tool for faster
    browsing of the repository. Enables
    --generate-sqlite flag.'

    munge { |value| @resource.munge_boolean_to_symbol(value) }
  end

  newproperty(:require_signature) do
    desc 'if "Require that imported packages should be signed.'

    munge { |value| @resource.munge_boolean_to_symbol(value) }
  end

  newproperty(:allowed_keys, :array_matching => :all) do
    desc "List of allowed signature keys that imported packages
    can be signed with. Comma separated values."
  end

  newproperty(:download_policy) do
    desc "content downloading policy"
    newvalues(:immediate, :background, :on_demand)
  end

  newproperty(:basicauth_user) do
    desc "username used to authenticate with sync location via HTTP basic auth"
  end

  newproperty(:basicauth_pass) do
    desc "password used to authenticate with sync location via HTTP basic auth"
  end

end
