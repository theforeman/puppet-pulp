require 'spec_helper'

describe 'pulp::repo::upstream' do
  context 'default parameters' do
    it { is_expected.to compile.with_all_deps }
    it do
      is_expected.to contain_yumrepo('pulp-2-stable')
        .with_baseurl('https://repos.fedorapeople.org/repos/pulp/pulp/stable/2/$releasever/$basearch/')
        .with_descr('Pulp 2 Production Releases')
        .with_enabled(true)
        .with_gpgcheck(true)
        .with_gpgkey('https://repos.fedorapeople.org/repos/pulp/pulp/GPG-RPM-KEY-pulp-2')
    end
  end
end
