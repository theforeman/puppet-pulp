require 'puppet'
require 'puppet/type/pulp_isorepo'
require './spec/support/type_examples.rb'

describe Puppet::Type.type(:pulp_isorepo) do
  describe 'namevar' do
    it 'has name as its namevar' do
      expect(described_class.key_attributes).to eq([:name])
    end
  end

  it_behaves_like 'an ensurable type'

  ['validate', 'verify_feed_ssl', 'remove_missing', 'serve_http', 'serve_https'].each do |param|
    it_behaves_like 'a boolean parameter', param
  end

  ['conf_file', 'feed_ca_cert', 'feed_cert', 'feed_key'].each do |param|
    it_behaves_like 'a path parameter', param
  end

  ['proxy_port', 'max_downloads', 'max_speed'].each do |param|
    it_behaves_like 'an integer parameter', param
  end
end
