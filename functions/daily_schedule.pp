# @api private
# @param seed A seed to pass to `fqdn_rand`.  A good choice is the repo name that this schedule will be for.
# @return Returns a 'pseudo-random' daily iso8601 schedule.
# @example Calling the function
#    pulp::daily_schedule('centos-7')
function pulp::daily_schedule(String $seed) >> String {
  $random_hour   = sprintf('%02d', fqdn_rand(23, $seed))
  $random_minute = sprintf('%02d', fqdn_rand(59, $seed))
  "2000-01-01T${random_hour}:${random_minute}Z/P1D"
}
