require 'net/http'
require 'net/https'
require 'openssl'
require 'uri'
require 'json'

module Puppet
  module Util
    class PulpUtil
      def initialize (config_path = '/etc/pulp/admin/admin.conf')
        config               = parse_config(config_path)
        @config              = {}
        @config[:host]       = config['server']['host']                 || Facter['fqdn'].value
        @config[:port]       = config['server']['port']                 || 443
        @config[:api_prefix] = config['server']['api_prefix']           || "/pulp/api"
        @config[:verify_ssl] = config['server']['verify_ssl']           || true
        @config[:cert_dir]   = config['filesystem']['id_cert_dir']      || "~/.pulp"
        @config[:cert_file]  = config['filesystem']['id_cert_filename'] || "user-cert.pem"
      end

      def get_repos(type=nil)
        repos = request_api('/v2/repositories/')
        return repos.select { |repo| repo['notes']['_repo-type'] == type } if type
        repos
      end

      def get_repo_syncs(repo_id)
        # returns an array with 2 values: an array of sync schedules and the repo type
        raise '[get_repo_syncs] Repo id should never be nil' unless repo_id and repo_id != ''
        info = request_api("/v2/repositories/#{repo_id}/")
        return nil unless info

        # we need to see the repo type first
        case info['notes']['_repo-type']
        when 'rpm-repo'
          importer = 'yum_importer'
        when 'puppet-repo'
          importer = 'puppet_importer'
        when 'iso-repo'
          importer = 'iso_importer'
        else
          Puppet.debug "[get_repo_syncs] Unknown repo type #{info['notes']['_repo-type']} for repo #{repo_id}.\n"
          return nil
        end
        [request_api("/v2/repositories/#{repo_id}/importers/#{importer}/schedules/sync/?details=True"), info['notes']['_repo-type']]
      end

      def get_repo_info(repo_id)
        raise '[get_repo_info] Repo id should never be nil.' unless repo_id and repo_id != ''
        request_api("/v2/repositories/#{repo_id}/?details=True")
      end

      def get_role_info(role_id)
        raise '[get_role_info] Role id should never be nil.' unless role_id
        request_api("/v2/roles/#{role_id}/")
      end

      def get_role_users(role_id)
        raise '[get_role_users] Role id should never be nil.' unless role_id
        r = get_role_info(role_id)
        r['users']
      end

      def get_role_permissions(role_id)
        raise '[get_role_users] Role id should never be nil.' unless role_id
        r = get_role_info(role_id)
        r['permissions']
      end

      private

      def parse_config(path)
        settings = {
          'server' => {},
          'filesystem' => {},
        }

        if File.file?(path)
          begin
            file = File.new(path, "r")
            while (line = file.gets)
              if line =~ /(^#|^\s+$)/
                # nada
              elsif line =~ /^\[(.+)\]$/
                section = $1
                settings[section] = Hash.new
              elsif line =~ /^[^\[]/
                key, value = line.split(':')
                settings[section][key] = value.strip
              else
                raise "I don't understand this line: #{line}"
              end
            end
            file.close
          rescue => err
            puts "Exception: #{err}"
          end
        end

        settings
      end

      def request_api(path)
        begin
          uri = URI("https://#{@config[:host]}:#{@config[:port]}#{@config[:api_prefix]}#{path}")

          req = Net::HTTP::Get.new(uri.request_uri)
          resp = connection.request req
          if resp.code == '200'
            JSON.parse(resp.body)
          elsif resp.code == '404'
            nil
          else
            raise Puppet::Error, "https request returned code #{resp.code}. Connection details: url=#{uri}, cert_path=#{client_cert_path}."
          end
        rescue Exception => e
          raise Puppet::Error, "https request threw exception #{e.message}. Connection details: url=#{uri}, cert_path=#{client_cert_path}."
        end
      end

      def client_cert_path
        # when running from mco, home is not set
        begin
          cert_path = File.expand_path("#{@config[:cert_dir]}/#{@config[:cert_file]}")
        rescue
          cert_path = File.expand_path("/root/.pulp/#{@config[:cert_file]}")
        end
      end

      def connection
        unless @conn
          @conn = Net::HTTP.new(@config[:host], @config[:port])
          @conn.use_ssl = true

          cert_raw = File.read(client_cert_path)
          @conn.cert = OpenSSL::X509::Certificate.new(cert_raw)
          @conn.key = OpenSSL::PKey::RSA.new(cert_raw)

          # conn.ca_file = '/etc/pki/ca-trust/source/anchors/puppet_ca.pem'
          if [true, 'True', 1].include? @config[:verify_ssl]
            @conn.verify_mode = OpenSSL::SSL::VERIFY_PEER
          else
            @conn.verify_mode = OpenSSL::SSL::VERIFY_NONE
          end
        end

        @conn
      end

    end
  end
end
