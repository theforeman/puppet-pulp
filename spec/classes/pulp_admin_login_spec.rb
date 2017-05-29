require 'spec_helper'

describe 'pulp::admin::login' do
  context 'with login_method none' do
    let :params do
      {
        'login_method'     => 'none',
        'username'         => 'admin',
        'password'         => 'password',
        'id_cert_filename' => 'user_cert.pem',
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.not_to contain_exec('pulp-auth') }
  end

  context 'with login_method file' do
    let :params do
      {
        'login_method'     => 'file',
        'username'         => 'admin',
        'password'         => 'password',
        'id_cert_filename' => 'user_cert.pem',
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.not_to contain_exec('pulp-auth') }

    it do
      verify_exact_contents(catalogue, '/root/.pulp/admin.conf', [
        '[auth]',
        'username = admin',
        'password = password',
      ])
    end
  end

  context 'with login_method login' do
    let :params do
      {
        'login_method'     => 'login',
        'username'         => 'admin',
        'password'         => 'password',
        'id_cert_filename' => 'user_cert.pem',
      }
    end

    it { is_expected.to compile.with_all_deps }

    it do
      is_expected.to contain_exec('pulp-auth')
        .with_command('/usr/bin/pulp-admin login -u \'admin\' -p \'password\'')
        .with_creates('/root/.pulp/user_cert.pem')
        .that_requires('File[/root/.pulp]')
    end
  end
end
