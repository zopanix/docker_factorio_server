FROM debian:latest

MAINTAINER zopanix <zopanix@gmail.com>

WORKDIR /opt

COPY ./smart_launch.sh /opt

CMD ["./smart_launch.sh"]

EXPOSE 34197/udp

VOLUME "/opt/factorio/saves"

VOLUME "/opt/factorio/mods"

ENV FACTORIO_AUTOSAVE_INTERVAL 2

ENV FACTORIO_AUTOSAVE_SLOTS 3

ENV FACTORIO_DISSALOW_COMMANDS true

ENV FACTORIO_NO_AUTO_PAUSE false

RUN echo "# Installing curl" && \
    apt-get update && \
    apt-get install -y curl && \
    echo "# Downloading and unzipping factorio" && \
    curl -L -k https://www.factorio.com/get-download/0.12.30/headless/linux64 | tar -xzf - && \
    echo "# Cleaning" && \
    apt-get remove -y --purge curl  && \
    apt-get autoremove -y --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
