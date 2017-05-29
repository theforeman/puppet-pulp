require 'facter/util/pulp'

Facter.add(:pulp_consumer_server) do
  confine :kernel => 'Linux'
  setcode do
    Facter::Util::Pulp.pulp_consumer_server
  end
end
