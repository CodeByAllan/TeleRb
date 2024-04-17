# frozen_string_literal: true

module TeleRb
  # Message Methods
  module MediaMethods
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

    def send_sticker(chat_id, sticker_path, reply_to_message_id = nil)
      send_media(chat_id, sticker_path, reply_to_message_id, "sendSticker", :sticker)
    end

    private

    def send_media(chat_id, media_path, caption = nil, reply_to_message_id = nil, method, filekey)
      raise ArgumentError, "Invalid media type: {#{filekey.capitalize}" unless %i[photo audio video sticker
                                                                                  document].include?(filekey)

      CLIENT.post(@config.base_uri(method),
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
  end
end
