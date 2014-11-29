module Ramesh
  module Bot
    class Twitter
      class Config
        KEYS = %i(consumer_key consumer_secret access_token access_token_secret screen_name white_list)

        KEYS.each do |key|
          define_method(key) { @options[key] }
        end

        DEFAULTS = {
          white_list: []
        }

        def initialize(options = {})
          @options = DEFAULTS.merge(options)
        end
      end
    end
  end
end
