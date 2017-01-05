# curl -E ~/.pulp/user-cert.pem "https://$(hostname)/pulp/api/v2/repositories/optymyze_puppet_forge/importers/puppet_importer/schedules/sync/?details=True" | python -mjson.tool

Puppet::Type.newtype(:pulp_schedule) do
  @doc = <<-EOT
    doc 
  EOT

  autorequire(:file) do
    ['/etc/pulp/admin/admin.conf']
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

  newproperty(:enabled, :boolean => true) do
    desc 'if "false", the schedule will exist but will not trigger any executions'
    newvalues(:true, :false)
    defaultto :true

    munge do |value|
      case value
      when true, "true", :true
        :true
      when false, "false", :false
        :false
      end
    end
  end

  newproperty(:failure_threshold) do
    desc "number of failures before the schedule is
    automatically disabled; unspecified means the
    schedule will never be automatically disabled"
    newvalues(/^\d+$/)
  end

end
