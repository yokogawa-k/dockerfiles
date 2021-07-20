# Run awspec
#
# prehook:
#
# posthook:
#
# docker run --rm -it \
#       -v ${PWD}:/work:ro \
#       --name awspec \
#       yokogawa/awspec "$@"
#
FROM ruby:alpine

WORKDIR /app
COPY Gemfile /app/
ENV BUNDLE_GEMFILE /app/Gemfile
RUN set -ex \
      && bundle install --jobs=$(nproc)

WORKDIR /work
ENTRYPOINT ["bundle", "exec"]

CMD ["awspec", "--help"]
