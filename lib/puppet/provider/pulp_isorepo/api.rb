require File.expand_path('../../../util/repo_provider', __FILE__)

Puppet::Type.type(:pulp_isorepo).provide(:api, :parent => PuppetX::Pulp::RepoProvider) do

  commands :pulp_admin => '/usr/bin/pulp-admin'

  mk_resource_methods

  def self.repo_type
    'iso'
  end

  def repo_type
    'iso'
  end

  # special getter methods for parameters that receive a file and write the content
  [:feed_ca_cert,
    :feed_cert,
    :feed_key].each do |method|
    method = method.to_sym
    define_method method do
      if resource[method] && File.read(resource[method]) == @property_hash[method]
        resource[method]
      else
        nil
      end
    end
  end

  def self.get_resource_properties(repo_id)
    hash = {}

    repo = @pulp.get_repo_info(repo_id)
    unless repo
      hash[:ensure] = :absent
      return hash
    end

    hash[:display_name] = repo['display_name']
    hash[:description] = repo['description']
    hash[:note] = repo['notes']
    hash[:note].delete('_repo-type')

    repo['distributors'].each { |distributor|
      if distributor['id'] == 'iso_distributor'
        hash[:serve_http]       = distributor['config']['serve_http']
        hash[:serve_https]      = distributor['config']['serve_https']
      end
    }

    repo['importers'].each { |importer|
      if importer['id'] == 'iso_importer'
        hash[:feed]             = importer['config']['feed'] || ''
        hash[:validate]         = importer['config']['validate']
        hash[:feed_ca_cert]     = importer['config']['ssl_ca_cert']
        hash[:verify_feed_ssl]  = importer['config']['ssl_validation']
        hash[:feed_cert]        = importer['config']['ssl_client_cert']
        hash[:feed_key]         = importer['config']['ssl_client_key']
        hash[:proxy_host]       = importer['config']['proxy_host']
        hash[:proxy_port]       = importer['config']['proxy_port']
        hash[:proxy_user]       = importer['config']['proxy_username']
        hash[:proxy_pass]       = importer['config']['proxy_password']
        hash[:max_downloads]    = importer['config']['max_downloads']
        hash[:max_speed]        = importer['config']['max_speed']
        hash[:remove_missing]   = importer['config']['remove_missing']
      end
    }

    hash[:name] = repo_id
    hash[:ensure] = :present
    hash[:provider] = :pulp_isorepo

    Puppet.debug "Repo properties: #{hash.inspect}"

    hash
  end

  def params_hash
    {
      '--display-name'     => resource[:display_name],
      '--description'      => resource[:description],
      '--note'             => resource[:note],
      '--feed'             => resource[:feed],
      '--validate'         => resource[:validate],
      '--feed-ca-cert'     => resource[:feed_ca_cert],
      '--verify-feed-ssl'  => resource[:verify_feed_ssl],
      '--feed-cert'        => resource[:feed_cert],
      '--feed-key'         => resource[:feed_key],
      '--proxy-host'       => resource[:proxy_host],
      '--proxy-port'       => resource[:proxy_port],
      '--proxy-user'       => resource[:proxy_user],
      '--proxy-pass'       => resource[:proxy_pass],
      '--max-downloads'    => resource[:max_downloads],
      '--max-speed'        => resource[:max_speed],
      '--remove-missing'   => resource[:remove_missing],
      '--serve-http'       => resource[:serve_http],
      '--serve-https'      => resource[:serve_https],
    }
  end
end
