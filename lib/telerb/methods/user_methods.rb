# frozen_string_literal: true

module TeleRb
  # Message Methods
  module UserMethods
    def user_info(message)
      message["from"]
    end
  end
end
