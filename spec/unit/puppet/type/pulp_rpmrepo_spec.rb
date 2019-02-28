require 'puppet'
require 'puppet/type/pulp_rpmrepo'
require './spec/support/type_examples.rb'

describe Puppet::Type.type(:pulp_rpmrepo) do
  describe 'namevar' do
    it 'has name as its namevar' do
      expect(described_class.key_attributes).to eq([:name])
    end
  end

  it_behaves_like 'an ensurable type'

  ['validate', 'verify_feed_ssl', 'remove_missing', 'serve_http', 'serve_https', 'generate_sqlite', 'repoview', 'require_signature'].each do |param|
    it_behaves_like 'a boolean parameter', param
  end

  ['conf_file', 'feed_ca_cert', 'feed_cert', 'feed_key', 'host_ca', 'auth_ca', 'auth_cert', 'gpg_key'].each do |param|
    it_behaves_like 'a path parameter', param
  end

  ['proxy_port', 'max_downloads', 'max_speed', 'retain_old_count'].each do |param|
    it_behaves_like 'an integer parameter', param
  end
end
