Puppet::Type.newtype(:pulp_login) do
  @doc = <<-EOT
  EOT

  ensurable do
    desc <<-EOS
      Login/Logout a pulp user.
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
    desc "name"
  end

  newparam(:user) do
    desc "Username for pulp authentication"
    defaultto do
      @resource[:name]
    end
  end

  newparam(:pass) do
    desc "Password for pulp authentication"
    defaultto 'admin'
  end

end
