require 'puppet'
require 'puppet/type/pulp_rpmbind'
require './spec/support/type_examples.rb'

describe Puppet::Type.type(:pulp_rpmbind) do
  describe 'namevar' do
    it 'has repo_id as its namevar' do
      expect(described_class.key_attributes).to eq([:repo_id])
    end
  end

  it_behaves_like 'an ensurable type'
end
