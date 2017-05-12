require 'spec_helper'

describe 'pulp::plugin::python' do
  context 'with default parameters' do
    include_examples 'basic pulp plugin tests', 'python'

    it { is_expected.to contain_package('pulp-python-plugins') }
  end
end
