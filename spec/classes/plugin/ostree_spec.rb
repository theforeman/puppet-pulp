require 'spec_helper'

describe 'pulp::plugin::ostree' do
  context 'with default parameters' do
    include_examples 'basic pulp plugin tests', 'ostree'

    it { is_expected.to contain_package('ostree') }
    it { is_expected.to contain_package('pulp-ostree-plugins') }

    it do
      verify_exact_contents(catalogue, '/etc/pulp/server/plugins.conf.d/ostree_importer.json', [
        '{',
        '    "proxy_host": null,',
        '    "proxy_port": null,',
        '    "proxy_username": null,',
        '    "proxy_password": null',
        '}',
      ])
    end
  end

  context 'with parameters' do
    let :params do
      {
        'proxy_host'     => 'proxy.example.com',
        'proxy_port'     => 8080,
        'proxy_username' => 'admin',
        'proxy_password' => 'secret',
      }
    end

    include_examples 'basic pulp plugin tests', 'ostree'

    it do
      verify_exact_contents(catalogue, '/etc/pulp/server/plugins.conf.d/ostree_importer.json', [
        '{',
        '    "proxy_host": "proxy.example.com",',
        '    "proxy_port": 8080,',
        '    "proxy_username": "admin",',
        '    "proxy_password": "secret"',
        '}',
      ])
    end
  end
end
