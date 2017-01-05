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
        @config[:cert_dir]   = config['filesystem']['id_cert_dir']      || "~/.pulp"
        @config[:cert_file]  = config['filesystem']['id_cert_filename'] || "user-cert.pem"
      end

      def get_repos()
        request_api('', false)
      end

      def get_repo_syncs(repo_id)
        # returns an array with 2 values: an array of sync schedules and the repo type
        raise '[get_repo_syncs] Repo id should never be nil' if !repo_id or repo_id  == ''
        info = request_api(repo_id, false)
        return info if !info

        # we need to see the repo type first
        case info['notes']['_repo-type']
        when 'rpm-repo'
          importer = 'yum_importer'
        when 'puppet-repo'
          importer = 'puppet_importer'
        when 'iso-repo'
          importer = 'iso_importer'
        else
          print "[get_repo_syncs] Unknown repo type #{info['notes']['_repo-type']} for repo #{repo_id}.\n"
          return [[], nil]
        end
        [request_api(repo_id, true, "/importers/#{importer}/schedules/sync/"), info['notes']['_repo-type']]
      end

      def get_repo_info(repo_id)
        raise '[get_repo_info] Repo id should never be nil.' if !repo_id
        request_api(repo_id, true)
      end

      private

      def parse_config(path)
        if File.file?(path)
          settings = Hash.new
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

          settings
        end
      end

      def request_api(repo_id = nil, details = true, prefix = '')
        begin
          raise Puppet::Error, "[request_api] repo_id  can't be nil." if ! repo_id
          details_url = details ? '?details=True' : ''
          repo_url    = repo_id && !repo_id.empty? ? "#{repo_id}/"   : ''
          url         = "https://#{@config[:host]}:#{@config[:port]}#{@config[:api_prefix]}/v2/repositories/#{repo_url}/#{prefix}/#{details_url}"

          # when running from mco, home is not set
          begin
            cert_path = File.expand_path("#{@config[:cert_dir]}/#{@config[:cert_file]}")
          rescue
            cert_path = File.expand_path("/root/.pulp/#{@config[:cert_file]}")
          end
          uri = URI(url)
          uri.path.squeeze!("/")
          cert_raw = File.read(cert_path)

          req = Net::HTTP::Get.new(uri.request_uri)
          https = Net::HTTP.new(uri.host, uri.port)
          https.use_ssl = true
          https.cert = OpenSSL::X509::Certificate.new(cert_raw)
          https.key = OpenSSL::PKey::RSA.new(cert_raw)
          https.verify_mode = OpenSSL::SSL::VERIFY_PEER
          #  https.ca_file = '/etc/pki/ca-trust/source/anchors/puppet_ca.pem'
          resp = https.request req
          if resp.code == '200'
            JSON.parse(resp.body)
          else
            nil
          end
        rescue Exception => e
          raise Puppet::Error, "https request for repo \"#{repo_id}\# threw exception #{e.message}. Connection details: url=#{url}, cert_path=#{cert_path}."
        end
      end

    end
  end
end
