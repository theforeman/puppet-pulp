require 'spec_helper'

describe 'pulp' do
  context 'on redhat' do
    let :facts do
      on_supported_os['redhat-7-x86_64']
    end

    it { should contain_class('pulp::install') }
    it { should contain_class('pulp::config') }
    it { should contain_class('pulp::service') }
  end
end
