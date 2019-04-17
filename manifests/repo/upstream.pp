# Create the yum repo definition for the upstream repository
# @api private
class pulp::repo::upstream(
  $version = 2,
) {
  # From https://repos.fedorapeople.org/repos/pulp/pulp/rhel-pulp.repo
  yumrepo { "pulp-${version}-stable":
    baseurl  => "https://repos.fedorapeople.org/repos/pulp/pulp/stable/${version}/\$releasever/\$basearch/",
    descr    => "Pulp ${version} Production Releases",
    enabled  => true,
    gpgcheck => true,
    gpgkey   => "https://repos.fedorapeople.org/repos/pulp/pulp/GPG-RPM-KEY-pulp-${version}",
  }
}
