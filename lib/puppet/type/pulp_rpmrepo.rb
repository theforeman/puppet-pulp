# curl -E ~/.pulp/user-cert.pem "https://$(hostname)/pulp/api/v2/repositories/epel_el6/?details=True" | python -mjson.tool

Puppet::Type.newtype(:pulp_rpmrepo) do
  @doc = <<-EOT
    doc 
  EOT

  autorequire(:file) do
    ['/etc/pulp/admin/admin.conf']
  end

  def munge_boolean(value)
    case value
    when true, "true", :true
      :true
    when false, "false", :false
      :false
    else
      fail("munge_boolean only takes booleans")
    end
  end

  def munge_integer(value)
    Integer(value)
  rescue ArgumentError
    fail("munge_integer only takes integers")
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

  newparam(:name, :namevar => true) do
    desc "repo-id: uniquely identifies the rpm repo"
  end

  newparam(:conf_file) do
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
    desc "adds/updates/deletes notes to programmatically identify the  resource"
    validate do |value|
      if !value.kind_of?(Hash)
        raise ArgumentError,
        "Note property should be a hash"
      end
    end
  end

  newproperty(:feed) do
    desc "URL of the external source repository to sync"
  end

  newproperty(:validate, :boolean => true) do
    desc 'if "true", the size and checksum of each synchronized file will
    be verified against the repo metadata'
    #  defaultto :false
    newvalues(:true, :false)
    munge do |value|
      @resource.munge_boolean(value)
    end
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

  newproperty(:verify_feed_ssl, :boolean => true) do
    desc 'if "true", the feed\'s SSL certificate will be verified
    against the feed_ca_cert'
    # defaultto :false
    newvalues(:true, :false)
    munge do |value|
      @resource.munge_boolean(value)
    end
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
      @resource.munge_integer(value)
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
      @resource.munge_integer(value)
    end
  end

  newproperty(:max_speed) do
    desc "maximum bandwidth used per download thread, in bytes/sec,
    when synchronizing the repo"
    newvalues(/^\d+$/)
    munge do |value|
      @resource.munge_integer(value)
    end
  end

  newproperty(:remove_missing, :boolean => true) do
    desc 'if "true", units that were previously in the external
    feed but are no longer found will be removed from the  repository'
    # defaultto false
    newvalues(:true, :false)
    munge do |value|
      @resource.munge_boolean(value)
    end
  end

  newproperty(:retain_old_count) do
    desc "count indicating how many non-latest versions of a unit
    to keep in a repository"
    newvalues(/^\d+$/)
    munge do |value|
      @resource.munge_integer(value)
    end
  end

  newproperty(:relative_url) do
    desc "relative path the repository will be served from. Only
    alphanumeric characters, forward slashes, underscores and
    dashes are allowed. It defaults to the relative path of
    the feed URL"
    defaultto do
      @resource[:name]
    end
  end

  newproperty(:serve_http, :boolean => true) do
    desc 'if "true", the repository will be served over HTTP'
    defaultto :false
    newvalues(:true, :false)
    munge do |value|
      @resource.munge_boolean(value)
    end
  end

  newproperty(:serve_https, :boolean => true) do
    desc 'if "true", the repository will be served over HTTPS'
    defaultto :true
    newvalues(:true, :false)
    munge do |value|
      @resource.munge_boolean(value)
    end
  end

  newproperty(:checksum_type) do
    desc "type of checksum to use during metadata generation"
  end

  newproperty(:gpg_key) do
    desc "GPG key used to sign and verify packages in the repository"
  end

  newproperty(:generate_sqlite, :boolean => true) do
    desc 'if "true", sqlite files will be generated for the  repository metadata during publish'
    newvalues(:true, :false)
    munge do |value|
      @resource.munge_boolean(value)
    end
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
    desc "type of checksum to use during updateinfo.xml
    generation"
  end

  newproperty(:repoview, :boolean => false) do
    desc 'if "true", static HTML files will be generated
    during publish by the repoview tool for faster
    browsing of the repository. Enables
    --generate-sqlite flag.'
    newvalues(:true, :false)
    munge do |value|
      @resource.munge_boolean(value)
    end
  end

  newproperty(:require_signature, :boolean => false) do
    desc 'if "Require that imported packages should be signed.
    Defaults to False'
    newvalues(:true, :false)
    munge do |value|
      @resource.munge_boolean(value)
    end
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
    desc "username used to authenticate with sync location via HTTP
    basic auth"
  end

  newproperty(:basicauth_pass) do
    desc "password used to authenticate with sync location via HTTP
    basic auth"
  end

end
