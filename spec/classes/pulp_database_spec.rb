require 'spec_helper'

describe 'pulp::database' do
  let :facts do
    on_supported_os['redhat-7-x86_64']
  end

  context 'with default parameters' do
    it 'should configure mongodb::server for localhost' do
      is_expected.to contain_class('mongodb::server').with({
        'bind_ip' => ['127.0.0.1'],
        'ipv6'    => false,
        'ssl'     => '',
        'ssl_key' => '',
        'ssl_ca'  => '',
      })
    end
  end

  context 'with mongodb parameters' do
    let :params do
      {
        :bind_ip                   => ['0.0.0.0'],
        :mongodb_server_ssl        => true,
        :mongodb_server_ssl_bundle => '/tmp/cert.key',
        :mongodb_server_ssl_ca     => '/tmp/ca_cert.crt',
      }
    end

    it 'should configure mongodb::server for localhost' do
      is_expected.to contain_class('mongodb::server').with({
        'bind_ip' => ['0.0.0.0'],
        'ipv6'    => false,
        'ssl'     => true,
        'ssl_key' => '/tmp/cert-bundle.key',
        'ssl_ca'  => '/tmp/ca.crt',
      })
    end
  end

  context 'with mongodb parameters and ipv6' do
    let :params do
      {
        :mongodb_bind_ip           => ['0.0.0.0', '::/0'],
        :mongodb_ipv6              => true,
        :mongodb_server_ssl        => true,
        :mongodb_server_ssl_bundle => '/tmp/cert.key',
        :mongodb_server_ssl_ca     => '/tmp/ca_cert.crt',
      }
    end

    it 'should configure mongodb::server for localhost' do
      is_expected.to contain_class('mongodb::server').with({
        'bind_ip' => ['0.0.0.0', '::/0'],
        'ipv6'    => true,
        'ssl'     => true,
        'ssl_key' => '/tmp/cert.key',
        'ssl_ca'  => '/tmp/ca_cert.crt',
      })
    end
  end
end
