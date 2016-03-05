FROM ubuntu:latest

MAINTAINER zopanix@gmail.com

WORKDIR /opt

COPY ./smart_launch.sh /opt

RUN echo "# Installing WGET" && \
    apt-get update && \
    apt-get install -y curl && \
    echo "# Downloading and unzipping factorio" && \
    curl -L -k https://www.factorio.com/get-download/0.12.25/headless/linux64 | tar -xzf - && \
    echo "# Cleaning" && \
    apt-get remove -y --purge curl  && \
    apt-get autoremove -y --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["./smart_launch.sh"]

EXPOSE 34197/udp

VOLUME "/opt/factorio/saves"

