require 'spec_helper_acceptance'

describe 'Scenario: pulp_schedule' do
  include_examples 'the example', 'pulp_schedule.pp'

  it 'should have a schedule' do
    command('pulp-admin iso repo sync schedules list --repo-id Hurry') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to include 'Hurry' }
    end
  end

  let(:purge_schedules) do
    <<-EOS
    resources { 'pulp_schedule':
      purge => true,
    }
    EOS
  end

  it 'purges schedules' do
    apply_manifest(purge_schedules, catch_failures: true)
  end

  it 'should no longer have schedules' do
    command('pulp-admin iso repo sync schedules list --repo-id Hurry') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.not_to include 'Hurry' }
    end
  end
end
