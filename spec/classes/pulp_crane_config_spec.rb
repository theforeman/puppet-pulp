require 'spec_helper'

describe 'pulp::crane' do

  context 'with no parameters' do
    let :pre_condition do
      "class {'pulp::crane':}"
    end

    let :facts do
      on_supported_os['redhat-7-x86_64']
    end

    it "should set up the config file" do
      should contain_file('/etc/crane.conf').
        with({
          'ensure'  => 'file',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
        }).
        with_content(/^endpoint: foo.example.com:5000$/)
    end
  end

  context 'with parameters' do
    let :pre_condition do
      "class {'pulp::crane':
        port => 5001
      }"
    end

    let :facts do
      on_supported_os['redhat-7-x86_64']
    end

    it "should set the port" do
      should contain_file('/etc/crane.conf').
        with_content(/^endpoint: foo.example.com:5001$/)
    end
  end
end
