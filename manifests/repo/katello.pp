class pulp::repo::katello(
  $version  = 'latest',
  $yumcode  = "el${::operatingsystemmajrelease}",
  $enabled  = true,
  $gpgcheck = false,
  $gpgkey   = undef,
) {
  yumrepo { 'katello-pulp':
    baseurl  => "https://fedorapeople.org/groups/katello/releases/yum/${version}/pulp/${yumcode}/\$basearch/",
    descr    => 'Pulp Community Releases',
    enabled  => $enabled,
    gpgcheck => $gpgcheck,
    gpgkey   => $gpgkey,
  }
}
