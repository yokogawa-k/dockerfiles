FROM ruby:alpine

COPY Gemfile /
RUN set -ex \
      && bundle install --clean --jobs=$(nproc)

WORKDIR /work

ENTRYPOINT ["bundle", "exec", "cfdef"]
CMD ["--help"]
