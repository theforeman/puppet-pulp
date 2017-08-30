require 'spec_helper_acceptance'

describe 'Scenario: pulp-admin' do
  let(:pp) do
    <<-EOS
    class { '::pulp':
      manage_repo => true,
      # https://github.com/Katello/puppet-pulp/issues/138
      ssl_username => '',
      enable_admin => true,
    }
    pulp_rpmrepo { 'Zoo':
      feed => 'https://repos.fedorapeople.org/repos/pulp/pulp/demo_repos/zoo/',
    }
    pulp_isorepo { 'DataMonster':
    }
    EOS
  end

  it_behaves_like 'a idempotent resource'

  describe package('pulp-admin-client') do
    it { is_expected.to be_installed }
  end

  describe command('pulp-admin status') do
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe command('pulp-admin repo list') do
    its(:exit_status) { is_expected.to eq 0 }
    its(:stdout) { is_expected.to include 'Zoo' }
    its(:stdout) { is_expected.to include 'DataMonster' }
  end
end
