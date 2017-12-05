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
    exec { 'stop services':
      command     => '/bin/systemctl stop pulp_celerybeat pulp_workers pulp_resource_manager pulp_streamer && rm /var/lib/pulp/init.flag',
      subscribe   => Class['pulp::install'],
      before      => Class['pulp::database'],
      refreshonly => true,
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
