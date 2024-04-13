# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:bot) { TeleRb::TelegramBot.new }

  before(:each) do
    bot.config("123456789")
  end
  describe "settings" do
    it "configure the token" do
      expect(bot.instance_variable_get(:@token)).to eq("123456789")
    end
    it "define the available commands" do
      commands = [
        { command: "/start", description: "Start bot" },
        { command: "/help", description: "Show command list" }
      ].freeze
      expect(bot.set_commands(commands)).to eq("Commands set successfully")
    end

    it "get available commands" do
      expect(bot.get_commands).to eq(nil)
    end
  end
  describe "Text Message Sending" do
    it "send a text message" do
      chat_id = "123"
      message = "Hello World!"
      expect(bot.send_message(chat_id, message)).to eq("Message sent successfully!")
    end
  end

  describe "Photo Message Sending" do
    it "send a photo" do
      chat_id = "123"
      photo_path = "./spec/fixtures/exemple.jpg"
      caption = "Check out this photo!"
      allow(bot).to receive(:send_media).with(chat_id, photo_path, caption, nil, "sendPhoto",
                                              :photo).and_return("Photo Sent with success!")
      expect(bot.send_photo(chat_id, photo_path, caption)).to eq("Photo Sent with success!")
    end
  end
  describe "Audio Message Sending" do
    it "send an audio file" do
      chat_id = "123"
      audio_path = "./spec/fixtures/exemple.mp3"
      caption = "Listen to this audio!"
      allow(bot).to receive(:send_media).with(chat_id, audio_path, caption, nil, "sendAudio",
                                              :audio).and_return("Audio Sent with success!")
      expect(bot.send_audio(chat_id, audio_path, caption)).to eq("Audio Sent with success!")
    end
  end

  describe "Video Message Sending" do
    it "send a video" do
      chat_id = "123"
      video_path = "./spec/fixtures/exemple.mp4"
      caption = "Watch this video!"
      allow(bot).to receive(:send_media).with(chat_id, video_path, caption, nil, "sendVideo",
                                              :video).and_return("Video Sent with success!")
      expect(bot.send_video(chat_id, video_path, caption)).to eq("Video Sent with success!")
    end
  end

  describe "Document Message Sending" do
    it "send a document" do
      chat_id = "123"
      document_path = "./spec/fixtures/exemple.rar"
      caption = "Check out this document!"
      allow(bot).to receive(:send_media).with(chat_id, document_path, caption, nil, "sendDocument",
                                              :document).and_return("Document Sent with success!")
      expect(bot.send_document(chat_id, document_path, caption)).to eq("Document Sent with success!")
    end
  end

  describe "Sticker Message Sending" do
    it "send a sticker" do
      chat_id = "123"
      sticker_path = "./spec/fixtures/exemple.webp"
      allow(bot).to receive(:send_media).with(chat_id, sticker_path, nil, "sendSticker",
                                              :sticker).and_return("Sticker Sent with success!")
      expect(bot.send_sticker(chat_id, sticker_path)).to eq("Sticker Sent with success!")
    end
  end

  describe "Location Message Sending" do
    it "send a location" do
      chat_id = "123"
      latitude = 12.345
      longitude = 12.345
      expect(bot.send_location(chat_id, latitude, longitude)).to eq("Location Sent with success!")
    end
  end

  describe "Forwarding Message" do
    it "Send a Forwarded Message" do
      from_chat_id = 123
      to_chat_id = 456
      message_id = 1
      expect(bot.forward_message(from_chat_id, to_chat_id, message_id)).to eq("Forwarding was then done successfully!")
    end
  end
  describe "Get User Info" do
    let(:message) do
      {
        "message_id" => 1,
        "from" => {
          "id" => 1234,
          "is_bot" => false,
          "first_name" => "exemple",
          "last_name" => "test",
          "username" => "exemple",
          "language_code" => "en-us"
        },
        "chat" => {
          "id" => 1234,
          "first_name" => "exemple",
          "last_name" => "test",
          "username" => "exemple",
          "type" => "private"
        },
        "date" => "123456789",
        "text" => "hello"
      }
    end

    let(:expected_user_info) do
      {
        "id" => 1234,
        "is_bot" => false,
        "first_name" => "exemple",
        "last_name" => "test",
        "username" => "exemple",
        "language_code" => "en-us"
      }
    end

    it "returns correct user info" do
      expect(bot.user_info(message)).to eq(expected_user_info)
    end

    it "returns a Hash" do
      expect(bot.user_info(message)).to be_a(Hash)
    end

    it "does not modify the original message" do
      original = message.dup
      bot.user_info(message)
      expect(message).to eq(original)
    end
  end
end
