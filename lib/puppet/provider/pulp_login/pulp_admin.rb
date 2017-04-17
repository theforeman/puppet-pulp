require 'pp'
Puppet::Type.type(:pulp_login).provide(:pulp_admin) do
  desc "Login/logout a pulp user"

  commands :pulp_admin => '/usr/bin/pulp-admin'
  def exists?
    # always force relogin with the proper user
    pulp_admin('logout')
    false
  end

  def create
    # tmp_filename = write_temp_file("#{resource[:pass]}\n#{resource[:pass]}")
    # output = Puppet::Util::Execution.execute("/bin/pulp-admin -u #{resource[:user]}", {:stdinfile => tmp_filename})
    pulp_admin('login', '-u', resource[:user], '-p', resource[:pass])
  end

  def destroy
    pulp_admin('logout')
  end

end
