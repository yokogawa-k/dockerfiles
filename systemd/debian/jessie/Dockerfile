# Run systemd on Debian Jessie image
#
# docker run --rm -d \
#       --name systemd-jessie \
#       --privileged \
#       yokogawa/systemd-jessie
#

FROM debian:8-slim
LABEL maintainer="YOKOGAWA Kazuya <yokogawa-k@klab.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV SYSTEMD_PAGER less

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        systemd \
        libsystemd0 \
        systemd-sysv \
        dbus \
        libpam-systemd \
        less \
    && systemctl mask getty@tty1.service systemd-timesyncd.service \
    && rm -rf /var/lib/apt/lists/*

CMD ["/sbin/init"]
