require 'spec_helper'

describe 'pulp::plugin::docker' do
  context 'with default parameters' do
    include_examples 'basic pulp plugin tests', 'docker'

    it { is_expected.to contain_package('pulp-docker-plugins') }

    it do
      verify_exact_contents(catalogue, '/etc/pulp/server/plugins.conf.d/docker_importer.json', [
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

    include_examples 'basic pulp plugin tests', 'docker'

    it do
      verify_exact_contents(catalogue, '/etc/pulp/server/plugins.conf.d/docker_importer.json', [
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
