FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y \
  libpq-dev \
  libxml2-dev \
  libxslt1-dev \
  nodejs

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

ENV BUNDLE_PATH /box

COPY Gemfile* /usr/src/app/
RUN bundle install

COPY . /usr/src/app
