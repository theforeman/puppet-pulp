require 'spec_helper'

provider_class = Puppet::Type.type(:pulp_rpmbind).provider(:consumer)
describe provider_class do
  let(:resource) do
    Puppet::Type.type(:pulp_rpmbind).new(
      name: 'foo'
    )
  end

  let(:provider) { provider_class.new(resource) }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      before :each do
        Facter.clear
        facts.each { |k, v| Facter.add(k) { setcode { v } } }
      end

      describe 'instances' do
        it 'should have an instances method' do
          expect(described_class).to respond_to :instances
        end
      end

      describe 'prefetch' do
        it 'should have a prefetch method' do
          expect(described_class).to respond_to :prefetch
        end
      end

      describe '#create' do
        context 'repository exists on server' do
          it 'calls pulp-consumer and waits for bind to complete' do
            expect(provider).to receive(:consumer)
                    .with('rpm', 'bind', '--repo-id', 'foo')
                    .and_return('Bind tasks successfully created:')
            expect(provider).to receive(:wait_for_bind)
            expect { provider.create }.not_to raise_error
          end
        end
        context 'repository does not exist on server' do
          it 'raises error' do
            expect(provider).to receive(:consumer)
                    .with('rpm', 'bind', '--repo-id', 'foo')
                    .and_return('Repository [foo] does not exist on the server')
            expect { provider.create }
              .to raise_error(RuntimeError, 'Repository [foo] does not exist on the server')
          end
        end
      end

      describe '#wait_for_bind' do
        context 'bind works first time' do
          it 'doesn\'t raise exception' do
            expect(provider).to receive(:grep)
                    .with('-q', '--fixed-strings', '[foo]', '/etc/yum.repos.d/pulp.repo')
            expect { provider.wait_for_bind }.not_to raise_error
          end
        end
        context 'bind works after 2 retries' do
          it 'sleeps between retries and then succeeds' do
            expect(provider).to receive(:grep)
                    .with('-q', '--fixed-strings', '[foo]', '/etc/yum.repos.d/pulp.repo')
                    .twice.and_raise(Puppet::ExecutionFailure, '')
            expect(provider).to receive(:grep)
                    .with('-q', '--fixed-strings', '[foo]', '/etc/yum.repos.d/pulp.repo')
                    .once.and_return('')
            expect(provider).to receive(:sleep).twice
            expect { provider.wait_for_bind }.not_to raise_error
          end
        end
        context 'bind doesn\'t complete after 10 retries' do
          it 'tries 10 times then raises exception' do
            expect(provider).to receive(:grep).exactly(10).times
                    .with('-q', '--fixed-strings', '[foo]', '/etc/yum.repos.d/pulp.repo')
                    .and_raise(Puppet::ExecutionFailure, '')
            expect { provider.wait_for_bind }
              .to raise_error(RuntimeError, 'Pulp bind to foo failed')
          end
        end
      end
    end
  end
end
