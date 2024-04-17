# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:config) { TeleRb::TelegramConfig.new("123456789") }
  let(:bot) { TeleRb::TelegramBot.new(:config) }

  describe "Text Message Sending" do
    it "send a text message" do
      chat_id = "123"
      message = "Hello World!"
      allow(bot).to receive(:send_message).with(chat_id, message).and_return("Message sent successfully!")
      expect(bot.send_message(chat_id, message)).to eq("Message sent successfully!")
    end
  end
end
