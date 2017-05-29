require 'puppet/property/boolean'
# curl -E ~/.pulp/user-cert.pem "https://$(hostname)/pulp/api/v2/repositories/optymyze_puppet_forge/importers/puppet_importer/schedules/sync/?details=True" | python -mjson.tool

Puppet::Type.newtype(:pulp_schedule) do
  @doc = <<-EOT
    doc 
  EOT

  autorequire(:file) do
    ['/etc/pulp/admin/admin.conf']
  end

  autorequire(:pulp_isorepo) do
    [self[:name]]
  end

  autorequire(:pulp_rpmrepo) do
    [self[:name]]
  end

  autorequire(:pulp_puppetrepo) do
    [self[:name]]
  end

  ensurable do
    desc <<-EOS
      Create/Remove pulp repo schedules.
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

  newproperty(:schedule_time) do
    desc "time to execute in iso8601 format
    (yyyy-mm-ddThh:mm:ssZ/PiuT); the number of
    recurrences may be specified in this value"
    isrequired
  end

  newproperty(:enabled, :boolean => true, :parent => Puppet::Property::Boolean) do
    desc 'if "false", the schedule will exist but will not trigger any executions'
    defaultto :true
  end

  newproperty(:failure_threshold) do
    desc "number of failures before the schedule is
    automatically disabled; unspecified means the
    schedule will never be automatically disabled"
    newvalues(/^\d+$/)
  end

end
