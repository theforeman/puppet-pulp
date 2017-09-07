
require File.expand_path('../../../util/pulp_util', __FILE__)

Puppet::Type.type(:pulp_role).provide(:api) do
  commands :pulp_admin => '/usr/bin/pulp-admin'

  mk_resource_methods

  def initialize(resource={})
    super(resource)
    @pulp = Puppet::Util::PulpUtil.new
  end

  def exists?
    r = @pulp.get_role_info(name())
    !r.nil?()
  end

  def create
    manage_role('create', name())
  end

  def destroy
    manage_role('delete', name())
  end

  def users
    users = @pulp.get_role_users(name())

    @users = users
    @users
  end

  def users=(should)
    users_to_add = should - @users
    users_to_rm = @users - should
    users_to_add.each() do |user|
      if user_exist(user)
        role_user_mod("add", user, name())
      else
        Puppet::Util::Warnings.warnonce("#{user} does not exist in Pulp, can't be added to any role")
      end
    end
    users_to_rm.each() do |user|
      role_user_mod("remove", user, name())
    end
  end

  def permissions
    permissions = @pulp.get_role_permissions(name())

    @permissions = permissions
    @permissions
  end

  def permissions=(should)
    should.each_key() do |k|
      # if key is already there, inspect each permission associated
      if @permissions.has_key?(k)
        if should[k] != @permissions[k]
          perms_to_add = should[k] - @permissions[k]
          perms_to_add.each() do |perm|
            role_permission_mod("grant", k, perm, name())
          end

          perms_to_remove = @permissions[k] - should[k]
          perms_to_remove.each() do |perm|
            role_permission_mod("revoke", k, perm, name())
          end
        end
      # if key is absent, add all permissions
      else
        should[k].each() do |perm|
          role_permission_mod("grant", k, perm, name())
        end
      end
    end

    # Remove a key which should not be there anymore
    @permissions.each_key() do |k|
      unless should.has_key?(k)
        @permissions[k].each() do |perm|
          role_permission_mod("revoke", k, perm, name())
        end
      end
    end

  end

  def user_exist(login)
    stdout = pulp_admin(['auth', 'user', 'search', '--str-eq', 'login='+login])
    return true if stdout.to_s =~ /Login:/
  end

  def manage_role(action, role_id)
    pulp_admin(['auth', 'role', action, '--role-id', role_id])
  end

  def role_user_mod(action, user, role_id)
    pulp_admin(['auth', 'role', 'user', action, '--role-id', role_id, '--login', user])
  end

  def role_permission_mod(action, resource, permission, role_id)
    pulp_admin(['auth', 'permission', action, '--role-id', role_id, '--resource', resource, '-o', permission])
  end

end
