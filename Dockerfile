FROM ruby:2.1.5

RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
RUN mkdir -p /usr/src/app/lib/ramesh/bot/twitter
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
COPY ramesh-bot-twitter.gemspec /usr/src/app/
COPY lib/ramesh/bot/twitter/version.rb /usr/src/app/lib/ramesh/bot/twitter/

RUN bundle install -j4

COPY . /usr/src/app

CMD ["bundle", "exec", "bin/ramesh-bot-twitter"]
