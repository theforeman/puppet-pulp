require 'spec_helper'

describe 'pulp::scheduled_repo' do
  let :facts do
    on_supported_os['redhat-7-x86_64']
  end

  let :title do
    'centos-7'
  end

  context 'with default parameters' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to have_pulp_rpmrepo_resource_count(1) }
    it { is_expected.to have_pulp_schedule_resource_count(1) }
    it { is_expected.to contain_pulp_rpmrepo('centos-7') }
    it { is_expected.to contain_pulp_schedule('centos-7').with_schedule_time('2000-01-01T22:38Z/P1D') }
  end

  context 'when repo_type is \'puppet\'' do
    let :params do
      {
        repo_type: 'puppet'
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to have_pulp_rpmrepo_resource_count(0) }
    it { is_expected.to have_pulp_puppetrepo_resource_count(1) }
    it { is_expected.to contain_pulp_puppetrepo('centos-7') }
  end

  context 'when repo_type is \'iso\'' do
    let :params do
      {
        repo_type: 'iso'
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to have_pulp_rpmrepo_resource_count(0) }
    it { is_expected.to have_pulp_isorepo_resource_count(1) }
    it { is_expected.to contain_pulp_isorepo('centos-7') }
  end

  context 'with custom schedule' do
    let :params do
      {
        repo_schedule: '2019-01-01T00:42Z/P1D'
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_pulp_schedule('centos-7').with_schedule_time('2019-01-01T00:42Z/P1D') }
  end

  context 'with valid repo_config set' do
    let :params do
      {
        repo_config: {
          'display_name' => 'CentOS 7 Base Repo',
          'feed' => 'https://www.mirrorservice.org/sites/mirror.centos.org/7/os/x86_64'
        }
      }
    end

    it { is_expected.to compile.with_all_deps }
    it {
      is_expected.to contain_pulp_rpmrepo('centos-7').with(
        'display_name' => 'CentOS 7 Base Repo',
        'feed' => 'https://www.mirrorservice.org/sites/mirror.centos.org/7/os/x86_64'
      )
    }
  end

  context 'with invalid repo_config set' do
    let :params do
      {
        repo_config: {
          'no_such_parameter' => 'foo'
        }
      }
    end

    it { is_expected.to compile.and_raise_error(/no parameter named 'no_such_parameter'/) }
  end
end
