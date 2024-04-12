# TeleRb

Minimalist Telegram bot library for ruby

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add telerb

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install telerb

## Usage

### Initialize Bot

```

require 'telerb'

# Create a bot instance
bot = TeleRb::TelegramBot.new
bot.config('YOUR_TOKEN')

# Initialize bot
bot.listen do |message|
  chat_id = message['chat']['id']
  message_id = message['message_id']
  # Send a text message 
  bot.send_message(chat_id, 'Hello World', message_id)
end

```
The ***message_id*** parameter is only necessary if you want the message to be sent as a reply.

### Send Medias
```

  # Send a Photo
  bot.send_photo(chat_id, "./exemple.png", "test", message_id)
  # Send Document
  bot.send_document(chat_id, "./exemple.rar", "test", message_id)
  # Send Audio
  bot.send_audio(chat_id, "./exemple.mp3", "test", message_id)
  # Send Video
  bot.send_video(chat_id, "./exemple.mp4", "test", message_id)

```
### Commands
```

COMMANDS = [
  { command: "/start", description: "Start bot" },
  { command: "/help", description: "Show command list" }
].freeze

# Method that records bot commands
bot.set_commands(COMMANDS)

# Method that returns the available commands
bot.get_commands

```

### Forward Message

```

# Method for forwarding a message from one chat to another 
bot.forward_message(from_chat_id, to_chat_id, message_id)

```

### Get User Info

```

# Method to obtain information from a user
bot.user_info(message)

```

### Send Location

```

bot.location(chat_id, latitude, longitude, message_id)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/codebyallan/TeleRb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/codebyallan/TeleRb/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://github.com/CodeByAllan/TeleRb/blob/master/LICENSE.txt).

## Code of Conduct

Everyone interacting in the TeleRb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/codebyallan/TeleRb/blob/master/CODE_OF_CONDUCT.md).
