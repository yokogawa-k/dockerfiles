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

COPY Gemfile /
RUN set -ex \
      && bundle install --jobs=$(nproc)

WORKDIR /work
ENTRYPOINT ["bundle", "exec"]

CMD ["--help"]
