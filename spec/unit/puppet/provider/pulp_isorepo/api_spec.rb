require 'spec_helper'

describe Puppet::Type.type(:pulp_isorepo).provider(:api) do

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      before :each do
        Facter.clear
        facts.each do |k, v|
          Facter.stubs(:fact).with(k).returns Facter.add(k) { setcode { v } }
        end
      end

      describe 'instances' do
        it 'should have an instance method' do
          expect(described_class).to respond_to :instances
        end
      end

      describe 'prefetch' do
        it 'should have a prefetch method' do
          expect(described_class).to respond_to :prefetch
        end
      end

      #describe 'hash_to_params' do
      #  it 'should handle arrays' do
      #    expect(described_class.hash_to_params({'a' => ['first', 'second']}))
      #      .to eq([['a', 'first,second']])
      #  end

      #  it 'should handle hashes' do
      #    expect(described_class.hash_to_params({'a' => {'x' => 'first', 'y' => 'second'}}))
      #      .to eq([['a', 'x=first'], ['a', 'y=second']])
      #  end
      #end

      context 'without repos' do
        before :each do
          Puppet::Util::PulpUtil.any_instance.expects(:get_repos).with('iso-repo').returns([])
        end

        it { expect(described_class.instances.size).to eq 0 }
      end

      context 'with 1 repo' do
        before :each do
          item = {
            "scratchpad" => {},
            "display_name" => "DataMonster",
            "description" => nil,
            "distributors" =>  [
              {
                "repo_id" => "DataMonster",
                "last_updated" => "2017-05-31T16:54:53Z",
                "_href" => "/pulp/api/v2/repositories/DataMonster/distributors/iso_distributor/",
                "last_override_config" => {},
                "last_publish" => nil,
                "distributor_type_id" => "iso_distributor",
                "auto_publish" => true,
                "scratchpad" => {},
                "_ns" => "repo_distributors",
                "_id" => {"$oid"=>"592ef55d3f50e90d32037c87"},
                "config" => {
                  "serve_https" => true,
                  "serve_http" => false,
                },
                "id" => "iso_distributor",
              },
            ],
            "last_unit_added" => nil,
            "notes" => {"_repo-type"=>"iso-repo"},
            "last_unit_removed" => nil,
            "content_unit_counts" => {},
            "_ns" => "repos",
            "importers" => [
              {
                "repo_id" => "DataMonster",
                "last_updated" => "2017-05-31T16:54:53Z",
                "_href" => "/pulp/api/v2/repositories/DataMonster/importers/iso_importer/",
                "_ns" => "repo_importers",
                "importer_type_id" => "iso_importer",
                "last_override_config" => {},
                "last_sync" => nil,
                "scratchpad" => nil,
                "_id" => {"$oid"=>"592ef55d3f50e90d32037c86"},
                "config" => {
                  "validate" => false,
                  "remove_missing" => false,
                  "ssl_validation" => false,
                },
                "id" => "iso_importer"},
            ],
            "locally_stored_units" => 0,
            "_id" => {"$oid"=>"592ef55d3f50e90d32037c85"},
            "total_repository_units" => 0,
            "id" => "DataMonster",
            "_href" => "/pulp/api/v2/repositories/DataMonster/",
          }
          Puppet::Util::PulpUtil.any_instance.expects(:get_repos).with('iso-repo').returns([{'id' => 'DataMonster'}])
          Puppet::Util::PulpUtil.any_instance.expects(:get_repo_info).with('DataMonster').returns(item)
        end

        it { expect(described_class.instances.size).to eq 1 }

        it do
          expect(described_class.instances[0].instance_variable_get("@property_hash")).to eq( {
            :ensure          => :present,
            :name            => 'DataMonster',
            :display_name    => 'DataMonster',
            :description     => nil,
            :note            => {},
            :feed            => '',
            :feed_ca_cert    => nil,
            :feed_cert       => nil,
            :feed_key        => nil,
            :max_downloads   => nil,
            :max_speed       => nil,
            :provider        => :pulp_isorepo,
            :proxy_host      => nil,
            :proxy_port      => nil,
            :proxy_pass      => nil,
            :proxy_user      => nil,
            :remove_missing  => false,
            :serve_http      => false,
            :serve_https     => true,
            :validate        => false,
            :verify_feed_ssl => false,
          } )
        end
      end
    end
  end
end
