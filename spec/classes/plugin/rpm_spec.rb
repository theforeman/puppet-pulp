require 'spec_helper'

describe 'pulp::plugin::rpm' do
  context 'with default parameters' do
    include_examples 'basic pulp plugin tests', 'rpm'

    it { is_expected.to contain_package('pulp-rpm-plugins') }

    it do
      verify_exact_contents(catalogue, '/etc/pulp/server/plugins.conf.d/iso_importer.json', [
        '{',
        '    "proxy_host": null,',
        '    "proxy_port": null,',
        '    "proxy_username": null,',
        '    "proxy_password": null',
        '}',
      ])
    end

    it do
      verify_exact_contents(catalogue, '/etc/pulp/server/plugins.conf.d/yum_importer.json', [
        '{',
        '    "proxy_host": null,',
        '    "proxy_port": null,',
        '    "proxy_username": null,',
        '    "proxy_password": null,',
        '    "max_speed": null',
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
        'yum_max_speed'  => 10000,
      }
    end

    include_examples 'basic pulp plugin tests', 'rpm'

    it do
      verify_exact_contents(catalogue, '/etc/pulp/server/plugins.conf.d/iso_importer.json', [
        '{',
        '    "proxy_host": "proxy.example.com",',
        '    "proxy_port": 8080,',
        '    "proxy_username": "admin",',
        '    "proxy_password": "secret"',
        '}',
      ])
    end

    it do
      verify_exact_contents(catalogue, '/etc/pulp/server/plugins.conf.d/yum_importer.json', [
        '{',
        '    "proxy_host": "proxy.example.com",',
        '    "proxy_port": 8080,',
        '    "proxy_username": "admin",',
        '    "proxy_password": "secret",',
        '    "max_speed": 10000',
        '}',
      ])
    end
  end
end
