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
        facts.each do |k, v|
          Facter.stubs(:fact).with(k).returns Facter.add(k) { setcode { v } }
        end
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
            provider.expects(:consumer)
                    .with('rpm', 'bind', '--repo-id', 'foo')
                    .returns('Bind tasks successfully created:')
            provider.expects(:wait_for_bind)
            expect(provider.create)
          end
        end
        context 'repository does not exist on server' do
          it 'raises error' do
            provider.expects(:consumer)
                    .with('rpm', 'bind', '--repo-id', 'foo')
                    .returns('Repository [foo] does not exist on the server')
            expect { provider.create }
              .to raise_error(RuntimeError, 'Repository [foo] does not exist on the server')
          end
        end
      end

      describe '#wait_for_bind' do
        context 'bind works first time' do
          it 'doesn\'t raise exception' do
            provider.expects(:grep)
                    .with('-q', '^\[foo\]$', '/etc/yum.repos.d/pulp.repo')
            expect { provider.wait_for_bind }.not_to raise_error
          end
        end
        context 'bind works after 2 retries' do
          it 'sleeps between retries and then succeeds' do
            provider.expects(:grep).times(3)
                    .with('-q', '^\[foo\]$', '/etc/yum.repos.d/pulp.repo')
                    .raises(Puppet::ExecutionFailure, '')
                    .raises(Puppet::ExecutionFailure, '')
                    .then.returns('')
            provider.expects(:sleep).twice
            expect { provider.wait_for_bind }.not_to raise_error
          end
        end
        context 'bind doesn\'t complete after 10 retries' do
          it 'tries 10 times then raises exception' do
            provider.expects(:grep).times(10)
                    .with('-q', '^\[foo\]$', '/etc/yum.repos.d/pulp.repo')
                    .raises(Puppet::ExecutionFailure, '')
            expect { provider.wait_for_bind }
              .to raise_error(RuntimeError, 'Pulp bind to foo failed')
          end
        end
      end
    end
  end
end
