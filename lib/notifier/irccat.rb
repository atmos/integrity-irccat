require 'rubygems'
require 'integrity' unless defined?(Integrity)
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
        notify "[#{build.project.name}] Build by #{build.commit_author.name} #{build.successful? ? "was successful" : "failed"} - #{build_url}"
      end

      def notify(message)
        ::IrcCat::TcpClient.notify(host, port, message)
      end
    end
  end
end
