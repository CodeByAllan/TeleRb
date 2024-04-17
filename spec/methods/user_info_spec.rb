# frozen_string_literal: true

require "./lib/telerb"

RSpec.describe TeleRb::TelegramBot do
  let(:config) { TeleRb::TelegramConfig.new("123456789") }
  let(:bot) { TeleRb::TelegramBot.new(:config) }
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
