require 'spec_helper'

describe 'pulp::plugin::parent_node' do
  context 'with default parameters' do
    include_examples 'basic pulp plugin tests', 'nodes'

    it { is_expected.to contain_package('pulp-nodes-parent') }
  end
end
