# provides the ability to specify fragments for the ssl
#   virtual host defined for a Pulp server
#
#  === Parameters:
#
#  $ssl_content:: content of the ssl virtual host fragment
#
#  $order:: the order in which to load the concat fragments
#
define pulp::apache::fragment(
  String $ssl_content,
  Integer $order = 15,
) {
  concat::fragment { $name:
    target  => '05-pulp-https.conf',
    content => $ssl_content,
    order   => $order,
  }
}
