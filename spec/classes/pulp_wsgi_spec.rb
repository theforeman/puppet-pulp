describe 'pulp::apache::mod_wsgi' do
  let :pre_condition do
    "class {'pulp':}"
  end

  context 'on EL7' do
    let :default_facts do
      on_supported_os['redhat-7-x86_64']
    end

    let :facts do
      default_facts
    end

    it 'should include apache::mod::wsgi' do
      is_expected.to contain_class('apache::mod::wsgi').with({
        :package_name => 'mod_wsgi',
        :mod_path     => 'mod_wsgi.so'
      })
    end
  end

  context 'on EL8' do
    let :default_facts do
      on_supported_os['redhat-8-x86_64']
    end

    let :facts do
      default_facts
    end

    it 'should include apache::mod::wsgi' do
      is_expected.to contain_class('apache::mod::wsgi').with({
        :package_name => 'mod_wsgi',
        :mod_path     => 'mod_wsgi_python3.so'
      })
    end
  end
end
