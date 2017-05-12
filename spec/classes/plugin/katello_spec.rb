require 'spec_helper'

describe 'pulp::plugin::katello' do
  context 'with default parameters' do
    include_examples 'basic pulp plugin tests', 'katello'

    it { is_expected.to contain_package('pulp-katello') }
  end
end
