# TeleRb

Minimalist Telegram bot library for ruby

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add telerb

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install telerb

## Usage


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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/codebyallan/TeleRb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/codebyallan/TeleRb/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://github.com/CodeByAllan/TeleRb/blob/master/LICENSE.txt).

## Code of Conduct

Everyone interacting in the TeleRb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/codebyallan/TeleRb/blob/master/CODE_OF_CONDUCT.md).
