require 'spec_helper'

describe 'pulp::katello_agent' do
  context 'on RedHat' do
    context 'install class without parameters' do
      let :facts do
        {
          :fqdn => 'localhost',
        } end

      it { should contain_class('pulp::katello_agent::install') }
      it { should contain_class('pulp::katello_agent::config') }
      it { should contain_class('pulp::katello_agent::params') }
      it { should contain_class('pulp::katello_agent::service') }

      it { should contain_package('katello-agent').with_ensure('installed') }

      it 'should set katelloplugin.conf file' do
        should contain_file('/etc/gofer/plugins/katelloplugin.conf').
          with_content(/^\[messaging\]$/).
          with_content(/^url=$/).
          with_content(/^uuid=$/).
          with_content(/^cacert=\/etc\/rhsm\/ca\/candlepin-local.pem$/).
          with_content(/^clientcert=\/etc\/pki\/consumer\/bundle.pem$/).
          with_ensure('file')
      end
    end
  end
end
