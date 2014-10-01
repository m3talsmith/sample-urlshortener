FROM m3talsmith/ruby:2.1.3
MAINTAINER Michael Christenson <michael@rebelhold.com>

RUN apt-get update
RUN apt-get upgrade

RUN apt-get install -qy mysql-server libmysqlclient-dev
RUN gem install bundler --no-ri --no-rdoc

RUN adduser --disabled-password --home=/deploy --gecos "" deploy

ADD ./ /deploy
RUN chown -R deploy:deploy /deploy

EXPOSE 3000
USER deploy

ENV RAILS_ENV production
ENV SAMPLE_URL_DB_USERNAME root
ENV SAMPLE_URL_DB_PASSWORD ''

WORKDIR /deploy

RUN bundle install --path .bundle --without development test
RUN cp config/database.yml.example config/database.yml
# RUN bundle exec rake db:create
# RUN bundle exec rake db:migrate
# RUN bundle exec rake db:test:prepare
# RUN bundle exec rake test
# 
# CMD bundle exec rails start
