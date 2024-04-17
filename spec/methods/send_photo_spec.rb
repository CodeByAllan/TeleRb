# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:config) { TeleRb::TelegramConfig.new("123456789") }
  let(:bot) { TeleRb::TelegramBot.new(:config) }

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
end
