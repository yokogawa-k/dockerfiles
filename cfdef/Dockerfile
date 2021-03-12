FROM ruby:alpine

COPY Gemfile /
RUN set -ex \
      && bundle config set --local clean "true" \
      && bundle config set --local path "vendor/bundle" \
      && bundle install --jobs=$(nproc)

WORKDIR /work

ENTRYPOINT ["bundle", "exec", "cfdef"]
CMD ["--help"]
