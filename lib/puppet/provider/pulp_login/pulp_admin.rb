Puppet::Type.type(:pulp_login).provide(:pulp_admin) do
  desc "Login/logout a pulp user"

  commands :pulp_admin => '/bin/pulp-admin'
  def exists?
    begin
      pulp_admin(['repo', 'list'])
    rescue => err
      false
    end
    true
  end

  def create
    pulp_admin('login', '-u', resource[:user], '-p', resource[:pass])
  end

  def destroy
    pulp_admin('logout')
  end

end
