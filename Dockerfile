FROM ruby:2.6.5-alpine3.11

ENV APP_IS_DOCKER=true

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN gem install -v 2.1.2 bundler \
&& bundle -v

RUN apk add --update build-base libxml2-dev libxslt-dev ruby-nokogiri git \
&& gem install ruboty 


COPY Gemfile Gemfile.lock Rakefile ./ 
COPY .bundle/ ./.bundle/
COPY .git/  ./.git/


 
RUN bundle config set path 'vendor/bundle' \
&& bundle install



CMD ["bundle", "exec", "ruboty"]