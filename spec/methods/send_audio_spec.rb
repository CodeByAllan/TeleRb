# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:config) { TeleRb::TelegramConfig.new("123456789") }
  let(:bot) { TeleRb::TelegramBot.new(:config) }

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
end
