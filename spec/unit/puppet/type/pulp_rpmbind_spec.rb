require 'puppet'
require 'puppet/type/pulp_rpmbind'

describe Puppet::Type.type(:pulp_rpmbind) do
  describe 'namevar' do
    it 'has repo_id as its namevar' do
      expect(described_class.key_attributes).to eq([:repo_id])
    end
  end

  describe 'ensure' do
    %i[present absent].each do |value|
      it "suppports #{value} as a value to :ensure" do
        expect { described_class.new(repo_id: 'test-repo', ensure: value) }
          .not_to raise_error
      end
    end

    it 'rejects other values' do
      expect { described_class.new(repo_id: 'test-repo', ensure: 'foo') }
        .to raise_error(Puppet::Error)
    end

    it 'defaults to present' do
      expect(described_class.new(repo_id: 'test-repo').should(:ensure))
        .to eq(:present)
    end
  end
end
