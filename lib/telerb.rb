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
      send_media(chat_id, photo_path, caption, reply_to_message_id, "sendPhoto", :photo)
    end

    def send_audio(chat_id, audio_path, caption = nil, reply_to_message_id = nil)
      send_media(chat_id, audio_path, caption, reply_to_message_id, "sendAudio", :audio)
    end

    def send_video(chat_id, video_path, caption = nil, reply_to_message_id = nil)
      send_media(chat_id, video_path, caption, reply_to_message_id, "sendVideo", :video)
    end

    def send_document(chat_id, document_path, caption = nil, reply_to_message_id = nil)
      send_media(chat_id, document_path, caption, reply_to_message_id, "sendDocument", :document)
    end

    def get_commands
      response = CLIENT.get("#{@base_uri}#{@token}/getMyCommands")
      response.parsed_response["result"]
    rescue StandardError => e
      puts "Error getting list of defined commands: #{e.message}"
      nil
    end

    def set_commands(commands)
      CLIENT.post("#{@base_uri}#{@token}/setMyCommands", { commands: commands }.to_json,
                  { "Content-Type" => "application/json" })
      "Commands set successfully"
    rescue StandardError => e
      puts "Error defining command list: #{e.message}"
      nil
    end

    def forward_message(from_chat_id, to_chat_id, message_id)
      CLIENT.post("#{@base_uri}#{@token}/forwardMessage",
                  { chat_id: to_chat_id, from_chat_id: from_chat_id, message_id: message_id })
      "Forwarding was then done successfully!"
    rescue StandardError => e
      puts "Error forwarding message: #{e.message}"
      nil
    end

    def user_info(message)
      message["from"]
    end

    private

    def send_media(chat_id, media_path, caption = nil, reply_to_message_id = nil, method, filekey)
      raise ArgumentError, "Invalid media type: {#{filekey.capitalize}" unless %i[photo audio video
                                                                                  document].include?(filekey)

      CLIENT.post("#{@base_uri}#{@token}/#{method}",
                  {
                    chat_id: chat_id,
                    reply_to_message_id: reply_to_message_id,
                    filekey.to_sym => File.new(media_path, "rb"),
                    caption: caption
                  },
                  { "Content-Type" => "multipart/form-data" })
      "#{filekey.capitalize} Sent with success!"
    rescue StandardError => e
      puts "Error when sending #{filekey.capitalize}: #{e.message}"
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
