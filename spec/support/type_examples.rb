shared_examples 'an ensurable type' do |param|
  param ||= 'ensure'
  describe param do
    %i[present absent].each do |value|
      it "accepts #{value} as a value" do
        expect { described_class.new(name: 'test', param => value) }.not_to raise_error
      end
    end

    it 'rejects other values' do
      expect { described_class.new(name: 'test', param => 'foo') }.to raise_error(Puppet::Error)
    end

    it 'defaults to present' do
      expect(described_class.new(name: 'test').should(param)).to eq(:present)
    end
  end
end

shared_examples 'a boolean parameter' do |param|
  describe param do
    [true, false, 'true', 'false'].each do |value|
      it "accepts #{value} as a value" do
        expect { described_class.new(name: 'test', param => value) }.not_to raise_error
      end
    end

    it 'rejects other values' do
      expect { described_class.new(name: 'test', param => 'foo') }.to raise_error(Puppet::Error)
    end
  end
end

shared_examples 'a path parameter' do |param|
  describe param do
    it 'accepts a full path' do
      expect { described_class.new(name: 'test', param => '/path/to/file') }.not_to raise_error
    end

    # TODO
    #it 'rejects an invalid path' do
    #  expect { described_class.new(name: 'test', param => '') }.to raise_error(Puppet::Error)
    #end

    #it 'rejects a relative path' do
    #  expect { described_class.new(name: 'test', param => 'file') }.to raise_error(Puppet::Error)
    #end
  end
end

shared_examples 'an integer parameter' do |param|
  describe param do
    it "accepts an integer" do
      expect { described_class.new(name: 'test-repo', param => 100) }.not_to raise_error
    end

    it "accepts a string" do
      expect { described_class.new(name: 'test-repo', param => '100') }.not_to raise_error
    end

    it "rejects nil" do
      expect { described_class.new(name: 'test-repo', param => nil) }.to raise_error(Puppet::Error)
    end

    it "rejects an empty string" do
      expect { described_class.new(name: 'test-repo', param => '') }.to raise_error(Puppet::Error)
    end

    it "rejects an string" do
      expect { described_class.new(name: 'test-repo', param => 'a') }.to raise_error(Puppet::Error)
    end
  end
end
