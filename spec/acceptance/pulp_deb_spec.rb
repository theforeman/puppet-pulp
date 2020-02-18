require 'spec_helper_acceptance'

describe 'Scenario: pulp-deb' do
  let(:pp) do
    <<-EOS
    class { '::pulp':
      manage_repo => true,
      ssl_username => '',
      enable_admin => true,
      enable_deb => true,
    }
    EOS
  end

  it_behaves_like 'a idempotent resource'

  describe package('pulp-deb-admin-extensions') do
    it { is_expected.to be_installed }
  end

  describe package('pulp-deb-plugins') do
    it { is_expected.to be_installed }
  end

  describe command('pulp-admin status') do
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe command('pulp-admin deb repo list') do
    its(:exit_status) { is_expected.to eq 0 }
  end
end
