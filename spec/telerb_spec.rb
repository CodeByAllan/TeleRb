# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:config) { TeleRb::TelegramConfig.new("123456789") }
  let(:bot) { TeleRb::TelegramBot.new(:config) }

  describe "settings" do
    it "configure the token" do
      expect(bot.instance_variable_get(:@config)).to eq(:config)
    end
  end
end
