DEFAULT_OS_FACTS = on_supported_os['redhat-7-x86_64']

shared_examples 'basic pulp plugin tests' do |name|
  let(:facts) { DEFAULT_OS_FACTS }
  let(:pre_condition) do
    'class { "::pulp":
      enable_rpm => false,
    }'
  end
  it { is_expected.to compile.with_all_deps }
  it { is_expected.to contain_pulp__plugin(name) }
end
