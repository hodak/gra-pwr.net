FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential nodejs && gem install bundler

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock
RUN bundle install

ADD . $APP_HOME
CMD ["bundle", "exec", "rails", "server", "--binding", "0.0.0.0"]
