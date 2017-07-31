class { '::pulp::repo::upstream': } ->
class { '::pulp':
  # https://github.com/Katello/puppet-pulp/issues/138
  ssl_username => '',
  enable_admin => true,
}

pulp_role { 'myrepo_admins':
  users       => ['alice', 'bob'],
  permissions => {
                   '/'                        => ['READ','EXECUTE'],
                   '/v2/repositories/myrepo/' => ['CREATE','READ','DELETE','EXECUTE','UPDATE']
                 },
  ensure      => 'present',
}
