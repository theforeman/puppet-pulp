require 'spec_helper'

describe 'pulp::admin' do
  context 'on RedHat' do
    context 'install class without parameters' do
      let :facts do
        on_supported_os['redhat-7-x86_64']
      end

      it { should contain_class('pulp::admin::install') }
      it { should contain_class('pulp::admin::config') }
      it { should contain_class('pulp::admin::params') }

      it { should contain_package('pulp-admin-client').with_ensure('installed') }

      it 'should set admin.conf file' do
        verify_exact_contents(catalogue, '/etc/pulp/admin/admin.conf', [
          '[server]',
          'host: foo.example.com',
          'port: 443',
          'api_prefix: /pulp/api',
          'verify_ssl: true',
          'ca_path: /etc/pki/tls/certs/ca-bundle.crt',
          'upload_chunk_size: 1048576',
          '[client]',
          'role: admin',
          '[filesystem]',
          'extensions_dir: /usr/lib/pulp/admin/extensions',
          'id_cert_dir: ~/.pulp',
          'id_cert_filename: user-cert.pem',
          'upload_working_dir: ~/.pulp/uploads',
          '[logging]',
          'filename: ~/.pulp/admin.log',
          'call_log_filename: ~/.pulp/server_calls.log',
          '[output]',
          'poll_frequency_in_seconds: 1',
          'enable_color: true',
          'wrap_to_terminal: false',
          'wrap_width: 80',
        ])
      end
    end

    context 'install with puppet param' do
      let(:params) do {
          'enable_puppet' => true,
        } end

      it { should contain_package('pulp-puppet-admin-extensions').with_ensure('installed') }

      it 'should set puppet.conf file' do
        verify_exact_contents(catalogue, '/etc/pulp/admin/conf.d/puppet.conf', [
          '[puppet]',
          'upload_working_dir = ~/.pulp/puppet-uploads',
          'upload_chunk_size = 1048576',
        ])
      end

    end

    context 'install with docker param' do
      let(:params) do {
          'enable_docker' => true,
        } end

      it { should contain_package('pulp-docker-admin-extensions').with_ensure('installed') }
    end

    context 'install with nodes param' do
      let(:params) do {
          'enable_nodes' => true,
        } end

      it { should contain_package('pulp-nodes-admin-extensions').with_ensure('installed') }
    end

    context 'install with python param' do
      let(:params) do {
          'enable_python' => true,
        } end

      it { should contain_package('pulp-python-admin-extensions').with_ensure('installed') }
    end

    context 'install with rpm param' do
      let(:params) do {
          'enable_rpm' => true,
        } end

      it { should contain_package('pulp-rpm-admin-extensions').with_ensure('installed') }
    end

    context 'install with params' do
      let(:params) do {
        'host' => 'pulp.company.net',
        'verify_ssl' => false,
      } end

      it 'should set the defaults file' do
        should contain_file('/etc/pulp/admin/admin.conf').
          with_content(/^\[server\]$/).
          with_content(/^host: pulp.company.net$/).
          with_content(/^verify_ssl: false$/).
          with_ensure('file')
      end
    end
  end
end
