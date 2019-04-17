# Provides the ability to specify fragments for the ssl virtual host defined
# for a Pulp server
#
# @param ssl_content
#   Content of the ssl virtual host fragment
#
# @param order
#   The order in which to load the concat fragments
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
