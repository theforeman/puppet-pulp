# @summary A wrapper that creates a pulp_Xrepo resource with and an associated pulp_schedule resource
#
# @example Basic usage with default `rpm` `repo_type` and 'random' daily schedule
#   pulp::scheduled_repo { 'centos-7':
#     repo_config => {
#       'display_name' => 'CentOS 7 Base Repo',
#       'feed'         => 'https://www.mirrorservice.org/sites/mirror.centos.org/7/os/x86_64',
#     },
#   }
#
# @param repo_type
#   Determines whether a `pulp_rpmrepo`, `pulp_puppetrepo` or `pulp_isorepo` resource is created.
# @param repo_config
#   Defines a hash of parameters to pass to the `pulp_Xrepo` resource.
# @param repo_schedule
#   An iso8601 schedule string or the special value 'daily'. Defaults to 'daily' which creates a `pulp_schedule` with a pseudo-random daily `schedule_time`.
define pulp::scheduled_repo
(
  Enum['rpm','puppet','iso'] $repo_type = 'rpm',
  Hash $repo_config = {},
  Variant[Enum['daily'],Pulp::Iso8601TimeInterval] $repo_schedule = 'daily',
)
{
  $schedule_time = $repo_schedule ? {
    'daily' => pulp::daily_schedule($name),
    default => $repo_schedule,
  }

  Resource["pulp_${repo_type}repo"] { $name:
    * => $repo_config,
  }

  pulp_schedule { $name:
    schedule_time => $schedule_time,
  }
}
