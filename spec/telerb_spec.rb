# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:bot) { TeleRb::TelegramBot.new }

  before(:each) do
    bot.config("123456789")
  end

  describe "#config" do
    it "Configure the token" do
      expect(bot.instance_variable_get(:@token)).to eq("123456789")
    end
  end

  describe "#send_message" do
    it "send a message" do
      chat_id = "123"
      message = "Hello World!"
      expect(bot.send_message(chat_id, message)).to eq("Message sent successfully!")
    end
  end

  describe "#set_commands" do
    it "define the available commands" do
      commands = [
        { command: "/start", description: "Start bot" },
        { command: "/help", description: "Show command list" }
      ].freeze
      expect(bot.set_commands(commands)).to eq("Commands set successfully")
    end
  end

  describe "#get_commands" do
    it "get available commands" do
      expect(bot.get_commands).to eq(nil)
    end
  end
  describe "#send_photo" do
    it "send a photo" do
      chat_id = "123"
      photo_path = "./spec/fixtures/exemple.jpg"
      caption = "Check out this photo!"
      allow(bot).to receive(:send_media).with(chat_id, photo_path, caption, nil, "sendPhoto",
                                              :photo).and_return("Photo Sent with success!")
      expect(bot.send_photo(chat_id, photo_path, caption)).to eq("Photo Sent with success!")
    end
  end
  describe "#send_audio" do
    it "send an audio file" do
      chat_id = "123"
      audio_path = "./spec/fixtures/exemple.mp3"
      caption = "Listen to this audio!"
      allow(bot).to receive(:send_media).with(chat_id, audio_path, caption, nil, "sendAudio",
                                              :audio).and_return("Audio Sent with success!")
      expect(bot.send_audio(chat_id, audio_path, caption)).to eq("Audio Sent with success!")
    end
  end

  describe "#send_video" do
    it "send a video" do
      chat_id = "123"
      video_path = "./spec/fixtures/exemple.mp4"
      caption = "Watch this video!"
      allow(bot).to receive(:send_media).with(chat_id, video_path, caption, nil, "sendVideo",
                                              :video).and_return("Video Sent with success!")
      expect(bot.send_video(chat_id, video_path, caption)).to eq("Video Sent with success!")
    end
  end

  describe "#send_document" do
    it "send a document" do
      chat_id = "123"
      document_path = "./spec/fixtures/exemple.rar"
      caption = "Check out this document!"
      allow(bot).to receive(:send_media).with(chat_id, document_path, caption, nil, "sendDocument",
                                              :document).and_return("Document Sent with success!")
      expect(bot.send_document(chat_id, document_path, caption)).to eq("Document Sent with success!")
    end
  end

  describe "#forward_message" do
    it "Forwarding message" do
      from_chat_id = 123
      to_chat_id = 456
      message_id = 1
      expect(bot.forward_message(from_chat_id, to_chat_id, message_id)).to eq("Forwarding was then done successfully!")
    end
  end
end
