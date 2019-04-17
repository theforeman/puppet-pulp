# provides the ability to specify fragments for the ssl virtual host defined
# for a pulp node
#
# @param ssl_content
#   Content of the ssl virtual host fragment
#
# @param order
#   The relative order compared to other fragments
define pulp::child::fragment(
  $ssl_content = undef,
  $order       = 15,
) {

  concat::fragment { $name:
    target  => '25-pulp-node-ssl.conf',
    content => $ssl_content,
    order   => $order,
  }

}
