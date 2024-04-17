# frozen_string_literal: true

module TeleRb
  # Message Methods
  module MessageMethods
    def send_message(chat_id, text, reply_to_message_id = nil)
      CLIENT.post(@config.base_uri("sendMessage"),
                  { chat_id: chat_id, text: text, reply_to_message_id: reply_to_message_id })
      "Message sent successfully!"
    rescue StandardError => e
      puts "Error sending message: #{e.message}"
      nil
    end

    def forward_message(from_chat_id, to_chat_id, message_id)
      CLIENT.post(@config.base_uri("forwardMessage"),
                  { chat_id: to_chat_id, from_chat_id: from_chat_id, message_id: message_id })
      "Forwarding was then done successfully!"
    rescue StandardError => e
      puts "Error forwarding message: #{e.message}"
      nil
    end

    def send_location(chat_id, latitude, longitude, reply_to_message_id = nil)
      CLIENT.post(@config.base_uri("sendLocation"),
                  { chat_id: chat_id, latitude: latitude, longitude: longitude,
                    reply_to_message_id: reply_to_message_id })
      "Location Sent with success!"
    rescue StandardError => e
      puts "Error when sending Location: #{e.message}"
      nil
    end
  end
end
