require 'spec_helper'

describe 'pulp' do
  context 'on redhat' do
    let :facts do
      on_supported_os['redhat-7-x86_64']
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('pulp::install') }
    it { is_expected.to contain_class('pulp::config') }
    it { is_expected.to contain_class('pulp::broker') }
    it { is_expected.to contain_class('pulp::database') }
    it { is_expected.to contain_class('pulp::apache') }
    it { is_expected.to contain_class('pulp::service') }

    services = ['Service[pulp_celerybeat]', 'Service[pulp_workers]', 'Service[pulp_resource_manager]', 'Service[pulp_streamer]']
    it { is_expected.to contain_apache__vhost('pulp-https') }
    it { is_expected.to contain_exec('migrate_pulp_db').that_notifies(services + ['Apache::Vhost[pulp-https]']) }
    it { is_expected.to contain_service('mongodb').that_comes_before(services) }
    it { is_expected.to contain_service('qpidd').that_comes_before(services) }
  end
end
