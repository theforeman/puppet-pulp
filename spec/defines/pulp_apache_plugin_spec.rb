require 'spec_helper'

describe 'pulp::apache_plugin' do
  let :facts do
    on_supported_os['redhat-7-x86_64']
  end

  let :title do
    'python'
  end

  context 'with default parameters' do
    it { is_expected.to compile.with_all_deps }

    it do
      verify_exact_contents(catalogue, '/etc/httpd/conf.d/pulp_python.conf', [
        'Alias /pulp/python /var/www/pub/python/',
        '<Directory /var/www/pub/python>',
        '    Options FollowSymLinks Indexes',
        '    DirectoryIndex index.html index.json',
        '</Directory>',
      ])
    end

    it do
      verify_exact_contents(catalogue, '/etc/httpd/conf.d/pulp-vhosts80/python.conf', [])
    end
  end

  context 'with parameters set to false' do
    let :params do
      {
        :confd    => false,
        :vhosts80 => false,
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.not_to contain_file('/etc/httpd/conf.d/pulp_python.conf') }
    it { is_expected.not_to contain_file('/etc/httpd/conf.d/pulp-vhosts80/python.conf') }
  end
end
