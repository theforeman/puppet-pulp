Puppet::Type.newtype(:pulp_rpmbind) do
  ensurable do
    desc 'Bind/unbind to an RPM repo'

    defaultvalues
    defaultto :present
  end

  newparam(:repo_id) do
    desc 'The repo-id'
    isnamevar
  end
end
