require 'spec_helper'

describe 'pulp::crane' do

 context 'on redhat' do
    let :facts do
      on_supported_os['redhat-7-x86_64']
    end

    it { should contain_class('pulp::crane::install') }
    it { should contain_class('pulp::crane::config') }
  end
end
