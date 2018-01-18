require 'spec_helper'

describe 'pulp::database' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'with explicit parameters' do
        context 'with database' do
          let :params do
            {
              :manage_db       => true,
              :database        => 'dpulp',
              :username        => 'upulp',
              :password        => 'pass',
              :migrate_timeout => 100,
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('mongodb::server') }
          it { is_expected.to contain_mongodb_database('dpulp') }

          it do
            is_expected.to contain_mongodb_user('upulp')
              .with_password('pass')
              .that_requires('Mongodb_database[dpulp]')
          end

          it do
            is_expected.to contain_exec('migrate_pulp_db')
              .with_timeout(100)
              .that_requires(['Mongodb_database[dpulp]', 'Mongodb_user[upulp]'])
          end
        end

        context 'with database' do
          let :params do
            {
              :manage_db       => false,
              :database        => 'dpulp',
              :username        => 'upulp',
              :password        => 'pass',
              :migrate_timeout => 100,
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.not_to contain_class('mongodb::server') }
          it { is_expected.not_to contain_mongodb_database('dpulp') }
          it { is_expected.not_to contain_mongodb_user('upulp') }
          it { is_expected.to contain_exec('migrate_pulp_db').with_timeout(100) }
        end
      end

      context 'with inherited parameters' do
        let :pre_condition do
          'include ::pulp'
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('mongodb::server') }
        it { is_expected.to contain_mongodb_database('pulp_database') }
        it { is_expected.not_to contain_mongodb_user('pulp') }

        it do
          is_expected.to contain_exec('migrate_pulp_db')
            .with_timeout(300)
            .that_requires('Mongodb_database[pulp_database]')
        end
      end
    end
  end
end
