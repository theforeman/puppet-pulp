require 'spec_helper'

describe 'pulp::child::service' do
  it { is_expected.to compile.with_all_deps }
  it { is_expected.to contain_service('goferd').with_ensure('running').with_enable(true) }
end
