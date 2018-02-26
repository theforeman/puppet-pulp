require 'pathname'

Puppet::Type.type(:pulp_rpmbind).provide(:consumer) do
  desc 'Bind/unbind to an RPM repo'

  confine osfamily: :redhat
  commands consumer: 'pulp-consumer'
  commands grep:     '/bin/grep'

  def self.repo_file
    default = '/etc/yum.repos.d/pulp.repo'
    begin
      repo_file = grep('-oP', '^repo_file:\s+\K.*', '/etc/pulp/consumer/consumer.conf')
      repo_file.strip!
    rescue Puppet::ExecutionFailure => e
      Puppet.debug "Couldn't find repo_file configuration in /etc/pulp/consumer/consumer.conf -> #{e.inspect}"
      return default
    end
    return repo_file if (Pathname.new repo_file).absolute?
    Puppet.debug "repo_file #{repo_file} is not an absolute path.  Using default"
    default
  end

  def self.instances
    begin
      binds = grep('-oP', '^\[\K.*(?=\]$)', repo_file)
    rescue Puppet::ExecutionFailure => e
      Puppet.debug "grepping for binds had an error -> #{e.inspect}"
      return {}
    end
    binds.split("\n").collect do |line|
      new(name: line, ensure: :present)
    end
  end

  def self.prefetch(resources)
    instances.each do |prov|
      if (resource = resources[prov.name])
        resource.provider = prov
      end
    end
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def create
    output = consumer('rpm', 'bind', '--repo-id', @resource[:name])
    raise "Repository [#{@resource[:name]}] does not exist on the server" if output =~ /does not exist/
    wait_for_bind # 'pulp-consumer rpm bind' happens asynchronously in the background
    @property_hash[:ensure] = :present
  end

  def destroy
    consumer('rpm', 'unbind', '--repo-id', @resource[:name])
    @property_hash[:ensure] = :absent
  end

  def wait_for_bind
    tries ||= 10
    grep('-q', "^\\[#{@resource[:name]}\\]$", self.class.repo_file)
  rescue Puppet::ExecutionFailure
    raise "Pulp bind to #{@resource[:name]} failed" unless (tries -= 1) > 0
    Puppet.debug("Waiting for pulp rpm bind to #{@resource[:name]} to take place")
    sleep 0.25
    retry
  else
    Puppet.debug("Pulp bind to #{@resource[:name]} was successful")
  end
end
