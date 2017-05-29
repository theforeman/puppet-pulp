require 'spec_helper_acceptance'

describe 'Scenario: pulp_isorepo' do
  include_examples 'the example', 'pulp_isorepo.pp'

  it 'should have a repo' do
    command('pulp-admin iso repo list') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to include 'DataMonster' }
    end
  end

  let(:purge_repos) do
    <<-EOS
    resources { 'pulp_isorepo':
      purge => true,
    }
    EOS
  end

  it 'purges repos' do
    apply_manifest(purge_repos, catch_failures: true)
  end

  it 'should no longer have repos' do
    command('pulp-admin iso repo list') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.not_to include 'DataMonster' }
    end
  end
end
