require 'spec_helper_acceptance'

describe 'Scenario: pulp_rpmrepo' do
  include_examples 'the example', 'pulp_rpmrepo.pp'

  it 'has 2 repos' do
    command('pulp-admin rpm repo list') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to include 'Yummy' }
      its(:stdout) { is_expected.to include 'defaults_example' }
    end
  end

  describe 'defaults_example' do
    let(:json) do
      output = command('curl -k --cert ~/.pulp/user-cert.pem https://localhost:443/pulp/api/v2/repositories/defaults_example/?details=true').stdout
      JSON.parse(output)
    end

    let(:yum_distributor) do
      json['distributors'].find { |distributor| distributor['id'] == 'yum_distributor' }
    end

    let(:yum_importer) do
      json['importers'].find { |importer| importer['id'] == 'yum_importer' }
    end

    it 'has "Display Name" set to defaults_example' do
      expect(json['display_name']).to eq('defaults_example')
    end
    it 'has "Validate" set to false' do
      expect(yum_importer['config']['validate']).to be false
    end
    it 'has "Remove Missing" set to false' do
      expect(yum_importer['config']['remove_missing']).to be false
    end
    it 'has "Require Signature" set to false' do
      expect(yum_importer['config']['require_signature']).to be false
    end
    it 'has "Verify Feed SSL" set to false' do
      expect(yum_importer['config']['ssl_validation']).to be false
    end
    it 'has "Repoview" set to false' do
      expect(yum_distributor['config']['repoview']).to be false
    end
    it 'has "Serve HTTP" set to false' do
      expect(yum_distributor['config']['http']).to be false
    end
    it 'has "Serve HTTPS" set to true' do
      expect(yum_distributor['config']['https']).to be true
    end
    it 'has "Relative URL" set to defaults_example' do
      expect(yum_distributor['config']['relative_url']).to eq('defaults_example')
    end
  end

  describe 'purging' do
    let(:purge_repos) do
      <<-EOS
    resources { 'pulp_rpmrepo':
      purge => true,
    }
      EOS
    end

    it 'purges repos' do
      apply_manifest(purge_repos, catch_failures: true)
    end

    it 'no longer has repos' do
      command('pulp-admin rpm repo list') do
        its(:exit_status) { is_expected.to eq 0 }
        its(:stdout) { is_expected.not_to include 'Yummy' }
      end
    end
  end
end
