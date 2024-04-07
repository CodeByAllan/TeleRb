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
      rescue StandardError => e
        puts "Error in listen method: #{e.message}"
      end
      sleep 2
    end

    def send_message(chat_id, text, reply_to_message_id = nil)
      CLIENT.post("#{@base_uri}#{@token}/sendMessage",
                  { chat_id: chat_id, text: text, reply_to_message_id: reply_to_message_id })
      "Message sent successfully!"
    rescue StandardError => e
      puts "Error sending message: #{e.message}"
      nil
    end

    def send_photo(chat_id, photo_path, caption = nil, reply_to_message_id = nil)
      CLIENT.post("#{@base_uri}#{@token}/sendPhoto",
                  {
                    chat_id: chat_id,
                    reply_to_message_id: reply_to_message_id,
                    photo: File.new(photo_path, "rb"),
                    caption: caption
                  },
                  { "Content-Type" => "multipart/form-data" })
      "Photo sent successfully!"
    rescue StandardError => e
      puts "Error sending photo: #{e.message}"
      nil
    end

    def get_updates(offset = nil)
      response = CLIENT.get("#{@base_uri}#{@token}/getUpdates", { offset: offset })
      response.parsed_response["result"]
    rescue StandardError => e
      puts "Error in get_updates method: #{e.message}"
      []
    end
  end
end
