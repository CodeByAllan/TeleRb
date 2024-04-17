# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:config) { TeleRb::TelegramConfig.new("123456789") }
  let(:bot) { TeleRb::TelegramBot.new(:config) }

  describe "commands action" do
    it "define the available commands" do
      commands = [
        { command: "/start", description: "Start bot" },
        { command: "/help", description: "Show command list" }
      ].freeze
      allow(bot).to receive(:set_commands).with(commands).and_return("Commands set successfully")
      expect(bot.set_commands(commands)).to eq("Commands set successfully")
    end

    it "get available commands" do
      allow(bot).to receive(:get_commands).and_return([])
      expect(bot.get_commands).to eq([])
    end
  end
end
