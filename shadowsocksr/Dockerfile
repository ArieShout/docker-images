FROM ubuntu:16.04

MAINTAINER ArieShout "arieshout@gmail.com"

ARG TZ=Asia/Shanghai

ENV SS_WORKDIR=/root/shadowsocksr/shadowsocks \
    SS_SERVER=0.0.0.0 \
    SS_PORT=443 \
    SS_METHOD=aes-256-cfb \
    SS_PASSWORD=specify-password \
    SSR_PROTOCOL=auth_aes128_sha1 \
    SSR_CRYPTO=tls1.2_ticket_auth

ADD entrypoint.sh /root

RUN set -ex \
        && apt-get update \
        && apt-get install -y wget build-essential python m2crypto git tzdata \
        && ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime \
        && dpkg-reconfigure -f noninteractive tzdata \
        && cd /root \
        && wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz \
            && mkdir -p /root/libsodium \
            && tar zxf LATEST.tar.gz --strip 1 -C /root/libsodium \
            && cd /root/libsodium \
            && ./configure \
            && make install \
            && ldconfig \
        && git clone https://github.com/shadowsocksr/shadowsocksr.git /root/shadowsocksr \
        && apt-get remove --purge -y wget build-essential git \
        && apt-get autoremove --purge -y \
        && apt clean \
        && rm -rf -- /var/lib/apt/lists \
                     /var/cache/apt/archives \
                     /root/libsodium \
                     /root/LATEST.tar.gz

ENTRYPOINT ["/root/entrypoint.sh"]

