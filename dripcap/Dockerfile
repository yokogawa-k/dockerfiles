# Run dripcap app in a container
#
# prehook:
#   xhost +local:
#
# posthook:
#   xhost -local:
#
# docker run --rm -it \
#       -v /etc/localtime:/etc/localtime:ro \
#       -v /tmp/.X11-unix:/tmp/.X11-unix \
#       -v "${HOME}/.dripcap:/root/.dripcap" \
#       -e DISPLAY=unix$DISPLAY \
#       --name dripcap \
#       --network host \
#       --cap-add net_admin \
#       yokogawa/dripcap "$@"
#

FROM debian:stretch

ENV LANG   ja_JP.UTF-8
ENV LC_ALL ${LANG}
ENV DEBIAN_FRONTEND noninteractive

RUN set -ex \
      && apt-get update \
      && apt-get install -y --no-install-recommends \
        libcap2 \
        libcap2-bin \
        gconf2 \
        libasound2 \
        libgtk2.0-0 \
        libnss3 \
        libxss1 \
        libxtst6 \
        locales \
        xdg-utils \
        fonts-takao \
        fonts-symbola \
    && rm -rf /var/lib/apt/lists/*

# setup locale
RUN sed -i -e "s/# ${LANG} UTF-8/${LANG} UTF-8/" /etc/locale.gen \
      && locale-gen ${LANG} \
      && /usr/sbin/update-locale LANG=${LANG}


ENV DRIPCAP_VERSION v0.6.15

# download the deb
RUN set -ex \
      && buildDeps=' \
          curl \
          ca-certificates \
        ' \
      && apt-get update \
      && apt-get install -y --no-install-recommends $buildDeps \
      && curl -sSOL "https://github.com/dripcap/dripcap/releases/download/${DRIPCAP_VERSION}/dripcap-linux-amd64.deb" \
      && dpkg -i dripcap-linux-amd64.deb \
      && rm -rf dripcap-linux-amd64.deb \
      && apt-get purge -y --auto-remove $buildDeps \
      && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/share/dripcap/dripcap"]
