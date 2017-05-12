require 'spec_helper'

describe 'pulp::repo::katello' do
  context 'default parameters' do
    let :facts do
      {
        :operatingsystemmajrelease => '7',
      }
    end

    it { is_expected.to compile.with_all_deps }
    it do
      is_expected.to contain_yumrepo('katello-pulp')
        .with_baseurl('https://fedorapeople.org/groups/katello/releases/yum/latest/pulp/el7/$basearch/')
        .with_descr('Pulp Community Releases')
        .with_enabled(true)
        .with_gpgcheck(false)
        .with_gpgkey(nil)
    end
  end
end
