FROM frolvlad/alpine-glibc:alpine-3.3_glibc-2.23

MAINTAINER zopanix <zopanix@gmail.com>

WORKDIR /opt

COPY ./smart_launch.sh /opt
COPY ./factorio.crt /opt

VOLUME /opt/factorio/saves /opt/factorio/mods

ENV FACTORIO_AUTOSAVE_INTERVAL=2 \
    FACTORIO_AUTOSAVE_SLOTS=3 \
    FACTORIO_DISSALOW_COMMANDS=true \
    FACTORIO_NO_AUTO_PAUSE=false \
    VERSION=0.12.33 \
    FACTORIO_SHA1=9802b22f428eb404369d496f6d40633a64984406

RUN apk --update add bash curl && \
    curl -sSL --cacert /opt/factorio.crt https://www.factorio.com/get-download/$VERSION/headless/linux64 -o /tmp/factorio_headless_x64_$VERSION.tar.gz && \
    echo "$FACTORIO_SHA1  /tmp/factorio_headless_x64_$VERSION.tar.gz" | sha1sum -c && \
    tar xzf /tmp/factorio_headless_x64_$VERSION.tar.gz && \
    rm /tmp/factorio_headless_x64_$VERSION.tar.gz

EXPOSE 34197/udp

CMD ["./smart_launch.sh"]

