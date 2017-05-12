require 'spec_helper'

describe 'pulp::plugin::puppet' do
  context 'with default parameters' do
    let(:facts) { DEFAULT_OS_FACTS.merge(:selinux => 'true') }

    let(:pre_condition) do
      'class { "::pulp":
      enable_rpm => false,
    }'
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_pulp__plugin('puppet') }
    it { is_expected.to contain_package('pulp-puppet-plugins') }
    it { is_expected.to contain_selboolean('pulp_manage_puppet').that_requires('Package[pulp-puppet-plugins]') }

    it do
      verify_exact_contents(catalogue, '/etc/pulp/server/plugins.conf.d/puppet_importer.json', [
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

    include_examples 'basic pulp plugin tests', 'puppet'

    it do
      verify_exact_contents(catalogue, '/etc/pulp/server/plugins.conf.d/puppet_importer.json', [
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
