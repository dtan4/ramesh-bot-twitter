# Ramesh Twitter bot

A Twitter bot, which replies Tokyo-Amesh image

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ramesh-bot-twitter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ramesh-bot-twitter

## Deploy to Heroku

1. Create bot account
2. Create Twitter app at [Twitter Application Management](https://apps.twitter.com/)
3. Get app tokens and keys
4. Clone this repository and deploy to Heroku

```shell
$ git clone https://github.com/dtan4/ramesh-bot-twitter.git your-ramesh-bot
$ cd your-ramesh-bot
$ heroku create your-ramesh-bot
$ git push heroku master
$ heroku config:set \
  RAMESH_BOT_ACCESS_TOKEN=... \
  RAMESH_BOT_ACCESS_TOKEN_SECRET=... \
  RAMESH_BOT_CONSUMER_KEY=... \
  RAMESH_BOT_CONSUMER_SECRET=...\
  RAMESH_BOT_SCREEN_NAME=your-ramesh-bot-screen-name
$ heroku ps:scale bot=1
```

## Config Variables

key | description | required
----|-------------|---------
`RAMESH_BOT_ACCESS_TOKEN` | Access token | o
`RAMESH_BOT_ACCESS_TOKEN_SECRET` | Access token secret | o
`RAMESH_BOT_CONSUMER_KEY` | Consumer key | o
`RAMESH_BOT_CONSUMER_SECRET` | Consumer secret | o
`RAMESH_BOT_SCREEN_NAME` | Screen name of your bot | o
`RAMESH_BOT_WHITE_LIST` | White list of screen names, which are allowed to send request |

## Contributing

1. Fork it ( https://github.com/dtan4/ramesh-bot-twitter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
