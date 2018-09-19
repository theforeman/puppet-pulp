require 'spec_helper'

describe 'pulp' do
  context 'on redhat' do
    let :facts do
      on_supported_os['redhat-7-x86_64']
    end

    context 'with default parameters' do
      it { is_expected.to compile.with_all_deps }
      it { is_expected.not_to contain_class('pulp::repo::upstream') }
      it { is_expected.to contain_class('pulp::install') }
      it { is_expected.to contain_class('pulp::config') }
      it { is_expected.to contain_class('pulp::broker') }
      it { is_expected.to contain_class('pulp::database') }
      it { is_expected.to contain_class('pulp::apache') }
      it { is_expected.to contain_class('pulp::service') }
      it { is_expected.not_to contain_class('pulp::crane') }

      services = ['Service[pulp_celerybeat]', 'Service[pulp_workers]', 'Service[pulp_resource_manager]', 'Service[pulp_streamer]']
      it { is_expected.to contain_apache__vhost('pulp-https') }
      it { is_expected.to contain_exec('migrate_pulp_db').that_notifies(services + ['Apache::Vhost[pulp-https]']) }
      it { is_expected.to contain_service('mongodb').that_comes_before(services) }
      it { is_expected.to contain_service('qpidd').that_comes_before(services) }
    end

    context 'with manage_repo => true' do
      it { is_expected.to compile.with_all_deps }
      it { is_expected.not_to contain_class('pulp::repo::upstream').that_requires('Class[pulp::install]') }
    end

    context 'with enable_crane => true' do
      let :params do
        {
          :enable_crane => true,
        }
      end
      it { is_expected.to compile.with_all_deps }
      it do is_expected.to contain_class('pulp::crane').with({
        :cert     => '/etc/pki/pulp/ca.crt',
        :key      => '/etc/pki/pulp/ca.key',
        :ca_cert  => '/etc/pki/pulp/ca.crt',
        :port     => '5000',
        :data_dir => '/var/lib/pulp/published/docker/v2/app',
        :debug    => false,
      }).without_ssl_chain
      end
      context 'with https_chain set' do
        let :params do
          {
            :enable_crane => true,
            :https_chain  => '/tmp/chain.crt',
          }
        end
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('pulp::crane').with_ssl_chain('/tmp/chain.crt') }
      end
    end
  end
end
