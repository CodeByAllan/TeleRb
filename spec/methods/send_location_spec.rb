# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:config) { TeleRb::TelegramConfig.new("123456789") }
  let(:bot) { TeleRb::TelegramBot.new(:config) }
  describe "Location Message Sending" do
    it "send a location" do
      chat_id = "123"
      latitude = 12.345
      longitude = 12.345
      allow(bot).to receive(:send_location).with(chat_id, latitude, longitude).and_return("Location Sent with success!")
      expect(bot.send_location(chat_id, latitude, longitude)).to eq("Location Sent with success!")
    end
  end
end
