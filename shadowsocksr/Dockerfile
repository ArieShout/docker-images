FROM ubuntu:16.04

MAINTAINER ArieShout "arieshout@gmail.com"

ARG TZ=Asia/Shanghai
ARG LIBSODIUM_VERSION=1.0.12
ARG SSR_REVISION=339c1ccee25b1b2157924324b22374c6514a4313

ENV SS_WORKDIR=/root/shadowsocksr/shadowsocks \
    SS_HOST=0.0.0.0 \
    SS_PORT=443 \
    SS_METHOD=aes-256-cfb \
    SS_PASSWORD="" \
    SSR_PROTOCOL=auth_aes128_sha1 \
    SSR_OBFS=tls1.2_ticket_auth

ADD entrypoint.sh /root

RUN set -ex \
        && apt-get update \
        && apt-get install -y wget build-essential python m2crypto git tzdata \
        && ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime \
        && dpkg-reconfigure -f noninteractive tzdata \
        && cd /root \
        && wget https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VERSION.tar.gz \
            && mkdir -p /root/libsodium \
            && tar zxf libsodium-$LIBSODIUM_VERSION.tar.gz --strip 1 -C /root/libsodium \
            && cd /root/libsodium \
            && ./configure --prefix=/usr \
            && make \
            && make install \
            && ldconfig \
        && git clone https://github.com/shadowsocksr/shadowsocksr.git /root/shadowsocksr \
        && cd /root/shadowsocksr \
        && git checkout -b working $SSR_REVISION \
        && apt-get remove --purge -y wget build-essential git \
        && apt-get autoremove --purge -y \
        && apt clean \
        && rm -rf -- /var/lib/apt/lists \
                     /var/cache/apt/archives \
                     /root/shadowsocksr/.git \
                     /root/libsodium \
                     /root/LATEST.tar.gz

ENTRYPOINT ["/root/entrypoint.sh"]

