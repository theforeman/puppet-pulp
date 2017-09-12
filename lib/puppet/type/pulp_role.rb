
Puppet::Type.newtype(:pulp_role) do
  @doc = <<-EOT
    doc
  EOT

  autorequire(:file) do
    ['/etc/pulp/admin/admin.conf']
  end

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc "role-id: uniquely identifies the role"
  end

  newproperty(:users, :array_matching => :all) do
    desc "users to add to this role"
  end

  newproperty(:permissions) do
    desc "resources/permissions to grant to this role"
  end

end
