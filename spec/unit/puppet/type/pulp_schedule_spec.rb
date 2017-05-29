require 'puppet'
require 'puppet/type/pulp_schedule'
require './spec/support/type_examples.rb'

describe Puppet::Type.type(:pulp_schedule) do
  describe 'namevar' do
    it 'has name as its namevar' do
      expect(described_class.key_attributes).to eq([:name])
    end
  end

  it_behaves_like 'an ensurable type'

  describe 'schedule_time' do
    it "accepts a string" do
      expect { described_class.new(name: 'test-repo', :schedule_time => '2007-03-01T13:00:00Z/2008-05-11T15:30:00Z' ) }
        .not_to raise_error
    end
  end

  ['enabled'].each do |param|
    it_behaves_like 'a boolean parameter', param
  end

  ['failure_threshold'].each do |param|
    it_behaves_like 'an integer parameter', param
  end
end
