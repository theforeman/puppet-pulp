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
      expect { described_class.new(:name => 'test-repo', :schedule_time => '2007-03-01T13:00:00Z/P1DT') }
        .not_to raise_error
    end
  end

  ['enabled'].each do |param|
    it_behaves_like 'a boolean parameter', param
  end

  ['failure_threshold'].each do |param|
    it_behaves_like 'an integer parameter', param
  end

  describe 'autorequiring' do
    before :each do
      @catalog = Puppet::Resource::Catalog.new
    end

    [:pulp_isorepo, :pulp_puppetrepo, :pulp_rpmrepo].each do |type|
      it "should autorequire the #{type} type" do
        @repo = Puppet::Type.type(type).new(:name => 'test-repo')
        @catalog.add_resource @repo

        @resource = described_class.new(:name => 'test-repo', :schedule_time => '2007-03-01T13:00:00Z/P1DT')
        @catalog.add_resource @resource

        req = @resource.autorequire
        expect(req.size).to eq(1)
        expect(req[0].target).to eq(@resource)
        expect(req[0].source).to eq(@repo)
      end
    end
  end
end
