# frozen_string_literal: true

# Telegram config
class TelegramConfig
  attr_accessor :offset

  def initialize(token)
    @offset = nil
    @token = token
  end

  def base_uri(method)
    "https://api.telegram.org/bot#{@token}/#{method}"
  end
end
