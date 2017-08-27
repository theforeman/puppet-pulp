require 'spec_helper_acceptance'

describe 'Scenario: install pulp' do
  let(:pp) do
    <<-EOS
    class { '::pulp':
      manage_repo => true,
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
end
