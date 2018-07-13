require 'spec_helper'

describe 'pulp::squid' do
  on_supported_os.each do |os, facts|
    let :facts do
      facts
    end

    describe "on #{os}" do
      it { is_expected.to compile.with_all_deps }
      it do
        is_expected.to contain_class('squid3')
          .with_http_port(['3128 accel defaultsite=127.0.0.1:8751'])
          .with_acl(['Safe_ports port 3128'])
          .with_maximum_object_size('5 GB')
          .with_maximum_object_size_in_memory('100 MB')
      end
    end
  end
end
