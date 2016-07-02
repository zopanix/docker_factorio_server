FROM frolvlad/alpine-glibc:alpine-3.3_glibc-2.23

MAINTAINER zopanix <zopanix@gmail.com>

WORKDIR /opt

COPY ./new_smart_launch.sh /opt
COPY ./factorio.crt /opt

VOLUME /opt/factorio/saves /opt/factorio/mods

ENV FACTORIO_AUTOSAVE_INTERVAL=2 \
    FACTORIO_AUTOSAVE_SLOTS=3 \
    FACTORIO_ALLOW_COMMANDS=false \
    FACTORIO_NO_AUTO_PAUSE=false \
    FACTORIO_LATENCY_MS=100 \
    VERSION=0.13.3 \
    FACTORIO_SHA1=142e2122bb7bcc16f4ef7ab8f839c8dffe6dc542 \
    FACTORIO_WAITING=false \
    FACTORIO_MODE=normal

RUN apk --update add bash curl && \
    curl -sSL --cacert /opt/factorio.crt https://www.factorio.com/get-download/$VERSION/headless/linux64 -o /tmp/factorio_headless_x64_$VERSION.tar.gz && \
    echo "$FACTORIO_SHA1  /tmp/factorio_headless_x64_$VERSION.tar.gz" | sha1sum -c && \
    tar xzf /tmp/factorio_headless_x64_$VERSION.tar.gz && \
    rm /tmp/factorio_headless_x64_$VERSION.tar.gz

EXPOSE 34197/udp
EXPOSE 27015/tcp

CMD ["./new_smart_launch.sh"]
