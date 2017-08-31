require 'spec_helper_acceptance'

describe 'Scenario: install pulp with authenticated mongodb' do
  let(:pp) do
    <<-EOS
    class { '::mongodb::server':
      auth           => true,
      create_admin   => true,
      admin_password => 'supersecret',
      store_creds    => true,
    } ->
    class { '::pulp':
      manage_repo  => true,
      db_username  => 'pulp',
      db_password  => 'secret',
      # https://github.com/Katello/puppet-pulp/issues/138
      ssl_username => '',
      enable_admin => true,
    }

    pulp_isorepo { 'DataMonster':
    }
    EOS
  end

  it_behaves_like 'a idempotent resource'

  ['httpd', 'mongod', 'pulp_celerybeat', 'pulp_workers', 'pulp_resource_manager', 'pulp_streamer'].each do |service_name|
    describe service(service_name) do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end

  describe port(80) do
    it { is_expected.to be_listening }
  end

  describe port(443) do
    it { is_expected.to be_listening }
  end

  describe command('pulp-admin status') do
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe command('pulp-admin repo list') do
    its(:exit_status) { is_expected.to eq 0 }
    its(:stdout) { is_expected.to include 'DataMonster' }
  end
end
