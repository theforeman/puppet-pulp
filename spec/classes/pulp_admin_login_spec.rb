require 'spec_helper'

describe 'pulp::admin::login' do
  context 'with an undefined password' do
    let :params do
      {
        'username'         => 'admin',
        'password'         => '',
        'id_cert_filename' => 'user_cert.pem',
      }
    end

    it { is_expected.not_to contain_exec('pulp-auth') }
  end

  context 'with a password' do
    let :params do
      {
        'username'         => 'admin',
        'password'         => 'password',
        'id_cert_filename' => 'user_cert.pem',
      }
    end

    it do
      is_expected.to contain_exec('pulp-auth')
        .with_command('/usr/bin/pulp-admin login -u \'admin\' -p \'password\'')
        .with_creates('/root/.pulp/user_cert.pem')
    end
  end
end
