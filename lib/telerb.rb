# frozen_string_literal: true

require_relative "telerb/version"
require_relative "telerb/http_client"

module TeleRb
  CLIENT = HttpClient.new
  # class telegram bot
  class TelegramBot
    def initialize
      @token = nil
      @offset = nil
      @base_uri = "https://api.telegram.org/bot"
    end

    def config(token)
      @token = token
    end

    def listen(&block)
      loop do
        updates = get_updates(@offset)
        updates.each do |update|
          block.call update["message"] if block_given? && update["message"]
          @offset = update["update_id"] + 1
        end
        sleep 2
      end
    end

    def send_message(chat_id, text, reply_to_message_id = nil)
      body = { chat_id: chat_id, text: text }
      body[:reply_to_message_id] = reply_to_message_id if reply_to_message_id
      response = CLIENT.post("#{@base_uri}#{@token}/sendMessage", body)
      response.parsed_response
    end

    def get_updates(offset = nil)
      response = CLIENT.get("#{@base_uri}#{@token}/getUpdates", { offset: offset })
      response.parsed_response["result"]
    end
  end
end
