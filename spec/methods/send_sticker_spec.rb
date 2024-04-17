# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:config) { TeleRb::TelegramConfig.new("123456789") }
  let(:bot) { TeleRb::TelegramBot.new(:config) }

  describe "Sticker Message Sending" do
    it "send a sticker" do
      chat_id = "123"
      sticker_path = "./spec/fixtures/exemple.webp"
      allow(bot).to receive(:send_media).with(chat_id, sticker_path, nil, "sendSticker",
                                              :sticker).and_return("Sticker Sent with success!")
      expect(bot.send_sticker(chat_id, sticker_path)).to eq("Sticker Sent with success!")
    end
  end
end
