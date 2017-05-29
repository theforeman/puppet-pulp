require 'puppet'
require 'puppet/type/pulp_register'
require './spec/support/type_examples.rb'

describe Puppet::Type.type(:pulp_register) do
  describe 'namevar' do
    it 'has name as its namevar' do
      expect(described_class.key_attributes).to eq([:name])
    end
  end

  it_behaves_like 'an ensurable type'
end
