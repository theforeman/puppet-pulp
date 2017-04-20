module Facter::Util::Pulp
  def self.consumer_status_matchdata
    status = Facter::Util::Resolution.exec('pulp-consumer status')
    return nil if status.nil?
    # Strip color from command output
    status.gsub!(/\e\[([;\d]+)?m/, '')
    /^This consumer is registered to the server\s\[(?<server_id>.*)\]\swith\sthe\sID\s\[(?<consumer_id>.*)\]\.$/.match(status)
  end

  def self.pulp_consumer_id
    matchdata = consumer_status_matchdata
    matchdata[:consumer_id] unless matchdata.nil?
  end

  def self.pulp_consumer_server
    matchdata = consumer_status_matchdata
    matchdata[:server_id] unless matchdata.nil?
  end
end
