require 'spec_helper_acceptance'

describe 'squid' do
  let(:pp) { 'include pulp::squid' }

  it_behaves_like 'a idempotent resource'

  describe service('squid') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe port(3128) do
    it { is_expected.to be_listening }
  end

  describe port(8751) do
    it { is_expected.to be_listening.on('127.0.0.1') }
  end
end
