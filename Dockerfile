FROM ruby:2.4.6
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /campaign-manager
WORKDIR /campaign-manager
COPY Gemfile /campaign-manager/Gemfile
COPY Gemfile.lock /campaign-manager/Gemfile.lock
RUN bundle install
COPY . /campaign-manager
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
