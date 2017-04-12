require 'spec_helper'

describe 'pulp::child::install' do
  it { is_expected.to compile.with_all_deps }
  ['pulp-katello', 'pulp-nodes-child', 'katello-agent'].each do |package|
    it { is_expected.to contain_package(package) }
  end
end
