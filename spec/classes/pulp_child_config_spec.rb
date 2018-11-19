require 'spec_helper'

describe 'pulp::child::config' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      describe "with inherited parameters" do
        let :pre_condition do
          'include pulp
          class {"::pulp::child":
            parent_fqdn => "parent.example.com",
          }'
        end

        it { is_expected.to compile.with_all_deps }

        it do
          is_expected.to contain_class('pulp::child::config')
            .with_node_certificate('/etc/pki/pulp/nodes/node.crt')
            .with_verify_ssl(true)
            .with_ca_path('/etc/pki/pulp/ca.crt')
            .with_oauth_user_id('admin')
            .with_oauth_key('pulp')
            .with_oauth_secret('secret')
        end
      end

      describe "with explicit parameters" do
        let :params do
          {
            'node_certificate' => '/etc/pki/pulp/node.crt',
            'verify_ssl' => false,
            'ca_path' => '/etc/pki/pulp/ca.pem',
            'oauth_user_id' => 'root',
            'oauth_key' => 'keeey',
            'oauth_secret' => 'very-secret',
          }
        end

        let :pre_condition do
          'file { "/etc/pulp/server.conf": }
          service { "goferd": }'
        end

        it 'should configure nodes.conf' do
          is_expected.to contain_file('/etc/pulp/nodes.conf').with_ensure('file')

          verify_exact_contents(catalogue, '/etc/pulp/nodes.conf', [
            '[main]',
            'node_certificate: /etc/pki/pulp/node.crt',
            'verify_ssl: false',
            'ca_path: /etc/pki/pulp/ca.pem',
            '[oauth]',
            'user_id: root',
            '[parent_oauth]',
            'key: keeey',
            'secret: very-secret',
            'user_id: root',
          ])
        end

        it { is_expected.to contain_file('/etc/pulp/server.conf').that_notifies('Service[goferd]') }
      end
    end
  end
end
