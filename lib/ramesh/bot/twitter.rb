require "ramesh/bot/twitter/version"
require "ramesh/bot/twitter/config"

require "logger"
require "ramesh"
require "tempfile"
require "twitter"

module Ramesh
  module Bot
    class Twitter
      attr_reader :config

      def initialize(options)
        @options = options
        STDOUT.sync = true
      end

      def start
        load_config
        tweet_loop
      end

      def screen_name
        @screen_name ||= @config.screen_name
      end

      def ramesh_client
        @ramesh_client ||= Ramesh::Client.new
      end

      def rest_client
        @rest_client ||= ::Twitter::REST::Client.new do |config|
          config.consumer_key = @config.consumer_key
          config.consumer_secret = @config.consumer_secret
          config.access_token = @config.access_token
          config.access_token_secret = @config.access_token_secret
        end
      end

      def streaming_client
        @streaming_client ||= ::Twitter::Streaming::Client.new do |config|
          config.consumer_key = @config.consumer_key
          config.consumer_secret = @config.consumer_secret
          config.access_token = @config.access_token
          config.access_token_secret = @config.access_token_secret
        end
      end

      def logger
        @logger ||= Logger.new(STDOUT)
      end

      private

      def load_config
        @config = Config.new(@options)
      end

      def tweet_loop
        streaming_client.user do |object|
          if object.is_a?(::Twitter::Tweet)
            reply_to_screen_name = object.user.screen_name

            if reply_to_screen_name != screen_name &&
                (@config.white_list.empty? || @config.white_list.include?(tweet_user_name))
              image = download_image

              begin
                logger.info(object.full_text)
                reply = rest_client.update_with_media("@#{reply_to_screen_name}", image, in_reply_to_status_id: object.id)
                logger.info(reply.full_text)
              ensure
                image.close
              end
            end
          end
        end
      end

      def download_image
        tmpfile = Tempfile.new("ramesh")
        ramesh_client.download_image(0, File.dirname(tmpfile.path), File.basename(tmpfile.path))
        tmpfile
      end
    end
  end
end
