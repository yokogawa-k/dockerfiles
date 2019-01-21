FROM ruby:alpine

COPY Gemfile Gemfile.lock /
RUN set -ex \
      && bundle install

WORKDIR /work

CMD ["roadwork", "--help"]
