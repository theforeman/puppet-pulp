require 'spec_helper'

describe 'pulp::crane' do

 context 'on redhat' do
    context 'with parameters' do
      let :params do
        {
          :port                      => 5001,
          :cert                      => '/tmp/cert.crt',
          :key                       => '/tmp/cert.key',
          :ca_cert                   => '/tmp/ca_cert.crt',
          :data_dir_polling_interval => 90,
          :debug                     => true,
          :ssl_protocol              => '-all +TLSv1.2'
        }
      end

      let :facts do
        on_supported_os['redhat-7-x86_64']
      end

      it { should contain_class('pulp::crane::install') }
      it { should contain_class('pulp::crane::config') }

      it "should set up the config file" do
        should contain_file('/etc/crane.conf').
          with({
            'ensure'  => 'file',
            'owner'   => 'root',
            'group'   => 'root',
            'mode'    => '0644',
          }).
          with_content(/^endpoint: foo.example.com:5001$/).
          with_content(/^data_dir_polling_interval: 90$/).
          with_content(/^debug: true$/)
      end

      it 'should configure apache vhost' do
        is_expected.to contain_apache__vhost('crane').with({
          :priority          => '03',
          :port              => 5001,
          :servername        => facts[:fqdn],
          :docroot           => '/usr/share/crane/',
          :ssl               => true,
          :ssl_verify_client => 'optional',
          :ssl_options       => '+StdEnvVars +ExportCertData +FakeBasicAuth',
          :ssl_verify_depth  => '3',
          :ssl_key           => '/tmp/cert.key',
          :ssl_cert          => '/tmp/cert.crt',
          :ssl_ca            => '/tmp/ca_cert.crt',
          :ssl_chain         => '/tmp/ca_cert.crt',
          :ssl_protocol      => '-all +TLSv1.2'
        })
      end
    end
  end
end
