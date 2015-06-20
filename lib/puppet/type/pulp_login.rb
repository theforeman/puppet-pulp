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

  newparam(:user) do
    defaultto 'admin'
  end

  newparam(:pass) do
    defaultto 'admin'
  end

end
