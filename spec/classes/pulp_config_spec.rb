require 'spec_helper'


describe 'pulp::config' do
  let :default_facts do
    on_supported_os['redhat-7-x86_64'].merge(:processorcount => 3)
  end

  context 'with no parameters' do
    let :pre_condition do
      "class {'pulp':}"
    end

    let :facts do
      default_facts
    end

    it "should configure pulp_workers" do
      should contain_file('/etc/default/pulp_workers').with({
        'ensure'  => 'file',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      })
    end

    describe 'with processor count less than 8' do

      it "should set the PULP_CONCURRENCY to the processor count" do
        should contain_file('/etc/default/pulp_workers').with_content(/^PULP_CONCURRENCY=3$/)
      end

    end

    describe 'with processor count more than 8' do
      let :facts do
        default_facts.merge({
          :processorcount => 12
        })
      end

      it "should set the PULP_CONCURRENCY to 8" do
        should contain_file('/etc/default/pulp_workers').with_content(/^PULP_CONCURRENCY=8$/)
      end
    end

    it 'should configure server.conf' do
      should contain_file('/etc/pulp/server.conf').
        with_content(/^topic_exchange: 'amq.topic'$/).
        with({
        'ensure'    => 'file',
        'owner'     => 'apache',
        'group'     => 'apache',
        'mode'      => '0600',
        'show_diff' => false,
      })
    end
  end

  context 'with database auth parameters on supported mongo' do
    let :pre_condition do
      "class {'pulp':
        db_username => 'rspec',
        db_password => 'rsp3c4l1f3',
       }"
    end

    let :facts do
      default_facts
    end

    it "should configure auth" do
      should contain_file('/etc/pulp/server.conf').
        with_content(/^username: rspec$/).
        with_content(/^password: rsp3c4l1f3$/)
    end
  end

  context 'with worker timeout' do
    let :pre_condition do
      "class {'pulp':
        worker_timeout => 80,
       }"
    end

    let :facts do
      default_facts
    end

    it "should configure worker timeout param" do
      should contain_file('/etc/pulp/server.conf').
        with_content(/^worker_timeout: 80$/)
    end
  end

  context "with proxy configuration" do
    let :pre_condition do
      "class {'pulp':
        enable_rpm     => true,
        proxy_url      => 'http://fake.com',
        proxy_port     => 7777,
        proxy_username => 'al',
        proxy_password => 'beproxyin'
      }"
    end

    let :facts do
      default_facts
    end

    it "should produce valid json" do
      should contain_file("/etc/pulp/server/plugins.conf.d/yum_importer.json").with_content(
        /"proxy_host": "http:\/\/fake.com",/
      ).with_content(
        /"proxy_port": 7777,/
      ).with_content(
        /"proxy_username": "al",/
      ).with_content(
        /"proxy_password": "beproxyin"/
      ).with({
        'ensure'    => 'file',
        'owner'     => 'root',
        'group'     => 'root',
        'mode'      => '0644',
        'show_diff' => false,
      })

    end

  end

  context "with show_conf_diff enabled" do
    let :pre_condition do
      "class {'pulp':
        show_conf_diff => true,
        enable_rpm     => true,
        enable_puppet  => true,
        enable_docker  => true,
        enable_ostree  => true,
      }"
    end

    let :facts do
      default_facts
    end

    it 'should configure server.conf' do
      should contain_file('/etc/pulp/server.conf').
        with_content(/^topic_exchange: 'amq.topic'$/).
        with({
        'ensure'    => 'file',
        'owner'     => 'apache',
        'group'     => 'apache',
        'mode'      => '0600',
        'show_diff' => true,
      })
    end

    it "should configure importers" do
      importer_params = {
        'ensure'    => 'file',
        'owner'     => 'root',
        'group'     => 'root',
        'mode'      => '0644',
        'show_diff' => true,
      }
      should contain_file("/etc/pulp/server/plugins.conf.d/yum_importer.json").with(importer_params)
      should contain_file("/etc/pulp/server/plugins.conf.d/iso_importer.json").with(importer_params)
      should contain_file("/etc/pulp/server/plugins.conf.d/puppet_importer.json").with(importer_params)
      should contain_file("/etc/pulp/server/plugins.conf.d/docker_importer.json").with(importer_params)
      should contain_file("/etc/pulp/server/plugins.conf.d/ostree_importer.json").with(importer_params)
    end
  end

  describe 'repo_auth' do
    context 'by default' do
      let :pre_condition do
        "class {'pulp':}"
      end

      let :facts do
        default_facts
      end

      it 'defaults to false' do
        should contain_file('/etc/pulp/repo_auth.conf').
          with_content(/^enabled: false$/)
      end
    end
    context 'when set to true' do
      let :pre_condition do
        "class {'pulp':
          repo_auth => true,
        }"
      end

      let :facts do
        default_facts
      end

      it 'sets enabled to true' do
        should contain_file('/etc/pulp/repo_auth.conf').
          with_content(/^enabled: true$/)
      end
    end
    context 'when set to false' do
      let :pre_condition do
        "class {'pulp':
          repo_auth => false,
        }"
      end

      let :facts do
        default_facts
      end

      it 'sets enabled to false' do
        should contain_file('/etc/pulp/repo_auth.conf').
          with_content(/^enabled: false$/)
      end
    end
  end
end
