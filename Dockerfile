FROM ruby:2.6.0
RUN bundle config --global frozen 1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /myapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

ENV DB_HOST=db
ENV DB_USERNAME=postgres
ENV DB_PASSWORD=password

CMD ["rails", "server", "-b", "0.0.0.0"]
