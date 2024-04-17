# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:config) { TeleRb::TelegramConfig.new("123456789") }
  let(:bot) { TeleRb::TelegramBot.new(:config) }

  describe "Forwarding Message" do
    it "Send a Forwarded Message" do
      from_chat_id = 123
      to_chat_id = 456
      message_id = 1
      allow(bot).to receive(:forward_message).with(from_chat_id, to_chat_id,
                                                   message_id).and_return("Forwarding was then done successfully!")
      expect(bot.forward_message(from_chat_id, to_chat_id, message_id)).to eq("Forwarding was then done successfully!")
    end
  end
end
