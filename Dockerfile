FROM ubuntu:latest

MAINTAINER zopanix@gmail.com

WORKDIR /opt

COPY ./smart_launch.sh /opt

RUN apt-get update && \
    apt-get install -y wget && \
    wget --no-check-certificate -o factorio.tar.gz https://www.factorio.com/get-download/0.12.25/headless/linux64 &&\
    tar -xzf factorio.tar.gz && \
    rm -rf factorio.tar.gz && \
    apt-purge-build &&\
    apt-clean


CMD ["./smart_launch.sh"]

EXPOSE 34197/udp

VOLUME "/opt/factorio/saves"

