# frozen_string_literal: true

module TeleRb
  # Message Methods
  module ActionsMethods
    def get_commands
      response = CLIENT.get(@config.base_uri("getMyCommands"))
      response.parsed_response["result"]
    rescue StandardError => e
      puts "Error getting list of defined commands: #{e.message}"
      nil
    end

    def set_commands(commands)
      CLIENT.post(@config.base_uri("setMyCommands"), { commands: commands }.to_json,
                  { "Content-Type" => "application/json" })
      "Commands set successfully"
    rescue StandardError => e
      puts "Error defining command list: #{e.message}"
      nil
    end
  end
end
