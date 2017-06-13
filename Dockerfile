FROM frolvlad/alpine-glibc:alpine-3.3_glibc-2.23

MAINTAINER zopanix <zopanix@gmail.com>

WORKDIR /opt

COPY ./new_smart_launch.sh /opt/
COPY ./factorio.crt /opt/

VOLUME /opt/factorio/saves /opt/factorio/mods

EXPOSE 34197/udp
EXPOSE 27015/tcp

CMD ["./new_smart_launch.sh"]

ENV FACTORIO_AUTOSAVE_INTERVAL=10 \
    FACTORIO_AUTOSAVE_SLOTS=5 \
    FACTORIO_AUTOSAVE_SERVERONLY=true \
    FACTORIO_AFK_AUTOKICK_INTERVAL=0 \
    FACTORIO_ALLOW_COMMANDS=admins-only \
    FACTORIO_AUTO_PAUSE=true \
    FACTORIO_PAUSE_ADMINONLY=true \
    VERSION=0.14.18 \
    FACTORIO_SHA1=8b919fe1c271ca773754f7644b72a8ddec363ae4 \
    FACTORIO_WAITING=false \
    FACTORIO_MODE=normal \
    FACTORIO_NAME= \
    FACTORIO_DESCRIPTION= \
    FACTORIO_MAX_PLAYERS=0 \
    FACTORIO_VISIBILITY_PUBLIC=true \
    FACTORIO_VISIBILITY_LAN=true \
    FACTORIO_MAX_UPLOAD_KBPS=0 \
    FACTORIO_IGNORE_PLAYER_LIMIT=false \
    FACTORIO_USER_USERNAME= \
    FACTORIO_USER_PASSWORD= \
#    FACTORIO_USER_TOKEN= \
    FACTORIO_GAME_PASSWORD= \
    FACTORIO_REQUIRE_USER_VALIDATION=false

RUN apk --update add bash curl && \
    curl -sSL --cacert /opt/factorio.crt https://www.factorio.com/get-download/$VERSION/headless/linux64 -o /tmp/factorio_headless_x64_$VERSION.tar.gz && \
    echo "$FACTORIO_SHA1  /tmp/factorio_headless_x64_$VERSION.tar.gz" | sha1sum -c && \
    tar xzf /tmp/factorio_headless_x64_$VERSION.tar.gz && \
    rm /tmp/factorio_headless_x64_$VERSION.tar.gz && \
    apk del curl
