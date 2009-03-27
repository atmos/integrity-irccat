require 'rubygems'
require 'integrity'
gem 'irc_cat'
require 'irc_cat/tcp_client'

module Integrity
  class Notifier
    class IrcCat < Notifier::Base
      attr_reader :host, :port

      def self.to_haml
        File.read File.dirname(__FILE__) / "config.haml"
      end

      def initialize(build, config={})
        @host = config.delete("host")
        @port = config.delete("port")
        super
      end

      def deliver!
        notify "[#{commit.project.name}] Build by #{commit.author.name} #{commit.successful? ? "was successful" : "failed"} - #{commit_url}"
      end

      def notify(message)
        ::IrcCat::TcpClient.notify(host, port, message)
      rescue Errno::ECONNREFUSED
        Integrity.log "Unable to connect to the IrcCat Bot"
      end
    end
  end
end
