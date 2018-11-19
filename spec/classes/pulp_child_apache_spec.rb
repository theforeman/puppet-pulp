require 'spec_helper'

describe 'pulp::child::apache' do
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
          is_expected.to contain_class('pulp::child::apache')
            .with_servername('foo.example.com')
            .with_ssl_cert('/etc/pki/pulp/ssl_apache.crt')
            .with_ssl_key('/etc/pki/pulp/ssl_apache.key')
            .with_ssl_ca('/etc/pki/pulp/ca.crt')
            .with_max_keep_alive(10000)
            .with_ssl_username('SSL_CLIENT_S_DN_CN')
        end
      end

      describe "with explicit parameters" do
        let :params do
          {
            'servername'     => 'pulp-node.example.com',
            'ssl_cert'       => '/etc/pki/pulp/apache.crt',
            'ssl_key'        => '/etc/pki/pulp/apache.key',
            'ssl_ca'         => '/etc/pki/pulp/ca.pem',
            'max_keep_alive' => 300,
            'ssl_username'   => 'SSL_USERNAME',
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('apache') }

        it do
          is_expected.to contain_apache__vhost('pulp-node-ssl')
            .with_servername('pulp-node.example.com')
            .with_docroot('/var/www/html')
            .with_port(443)
            .with_priority('25')
            .with_keepalive('on')
            .with_max_keepalive_requests(300)
            .with_directories({'path' => '/pulp/api', 'provider' => 'Location', 'custom_fragment' => 'SSLUsername SSL_USERNAME'})
            .with_ssl(true)
            .with_ssl_cert('/etc/pki/pulp/apache.crt')
            .with_ssl_key('/etc/pki/pulp/apache.key')
            .with_ssl_ca('/etc/pki/pulp/ca.pem')
            .with_ssl_verify_client('optional')
            .with_ssl_options('+StdEnvVars')
            .with_ssl_verify_depth('3')
            .with_custom_fragment('SSLInsecureRenegotiation On')
        end
      end

      [false, ''].each do |ssl_username|
        describe "with ssl_username => #{ssl_username}" do
          let :params do
            {
              'servername'     => 'pulp-node.example.com',
              'ssl_cert'       => '/etc/pki/pulp/apache.crt',
              'ssl_key'        => '/etc/pki/pulp/apache.key',
              'ssl_ca'         => '/etc/pki/pulp/ca.pem',
              'max_keep_alive' => 300,
              'ssl_username'   => ssl_username,
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('apache') }
          it { is_expected.to contain_apache__vhost('pulp-node-ssl').with_directories(nil) }
        end
      end
    end
  end
end
