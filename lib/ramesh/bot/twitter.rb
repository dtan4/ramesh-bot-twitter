require "ramesh/bot/twitter/version"
require "ramesh/bot/twitter/config"

require "logger"
require "twitter"

module Ramesh
  module Bot
    class Twitter
      attr_reader :config

      def initialize(argv)
        @argv = argv
      end

      def run
        load_config
        tweet_loop
      end

      def rest_client
        @rest_client ||= Twitter::REST::Client.new do |config|
          config.consumer_key = @config.consumer_key
          config.consumer_secret = @config.consumer_secret
          config.access_token = @config.access_token
          config.access_token_secret = @config.access_secret
        end
      end

      def streaming_client
        @streaming_client ||= Twitter::Streaming::Client.new do |config|
          config.consumer_key = @config.consumer_key
          config.consumer_secret = @config.consumer_secret
          config.access_token = @config.access_token
          config.access_token_secret = @config.access_secret
        end
      end

      def logger
        @logger ||= Logger.new($stdout)
      end

      private

      def load_config
        @config = Config.new(@argv)
      end

      def tweet_loop
        @streaming_client.user do |object|
          next unless object.is_a?(Twitter::Tweet)
          tweet_user_name = object.user.screen_name
          next unless @config.white_list.empty? || @config.white_list.include?(tweet_user_name)

          logger.info tweet_user_name
        end
      end
    end
  end
end
