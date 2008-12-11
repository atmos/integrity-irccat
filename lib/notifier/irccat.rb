require 'rubygems'
require 'integrity' unless defined?(Integrity)
require 'irccat'

module Integrity
  class Notifier
    class IrcCat < Notifier::Base
      attr_reader :uri
      
      def self.to_haml
        File.read File.dirname(__FILE__) / "config.haml"
      end

      def initialize(build, config={})
        @uri = config.delete("uri")
        super
      end

      def deliver!
        ShoutBot.shout(uri, :as => "IntegrityBot") do |channel|
          channel.say "#{build.project.name}: #{short_message}"
          channel.say build_url
        end
      end
    end
  end
end
