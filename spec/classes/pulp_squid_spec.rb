require 'spec_helper'

describe 'pulp::squid' do
  on_supported_os.each do |os, facts|
    let(:facts) { facts }

    describe "on #{os}" do
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('squid').with_maximum_object_size_in_memory('100 MB') }
      it { is_expected.to contain_squid__acl('Safe_ports').with_type('port').with_entries([3128]) }
      it { is_expected.to contain_squid__http_port('pulp internal port').with_port(3128).with_options('accel defaultsite=127.0.0.1:8751') }
      it { is_expected.to contain_squid__http_access('localhost').with_action('allow') }
      it { is_expected.to contain_squid__http_access('to_localhost').with_action('deny') }
      it { is_expected.to contain_squid__http_access('all').with_action('deny') }
      it { is_expected.to contain_squid__cache('all').with_action('allow') }
      it { is_expected.to contain_squid__cache_dir('/var/spool/squid') }
    end
  end
end
