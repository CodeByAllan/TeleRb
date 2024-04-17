# frozen_string_literal: true

require_relative "utils/http_client"
require_relative "methods/message_methods"
require_relative "methods/media_methods"
require_relative "methods/actions_methods"
require_relative "methods/user_methods"

module TeleRb
  CLIENT = HttpClient.new
  # class telegram bot
  class TelegramBot
    include MessageMethods
    include MediaMethods
    include ActionsMethods
    include UserMethods
    def initialize(config)
      @config = config
    end

    def listen(&block)
      loop do
        updates = get_updates(@config.offset)
        updates.each do |update|
          block.call update["message"] if block_given? && update["message"]
          @config.offset = update["update_id"] + 1
        end
      rescue StandardError => e
        puts "Error in listen method: #{e.message}"
      end
      sleep 2
    end

    private

    def get_updates(offset = nil)
      response = CLIENT.get(@config.base_uri("getUpdates"), { offset: offset })
      response.parsed_response["result"]
    rescue StandardError => e
      puts "Error in get_updates method: #{e.message}"
      []
    end
  end
end
