FROM ubuntu:latest

MAINTAINER zopanix@gmail.com

WORKDIR /opt

COPY ./factorio.tar.gz /opt

RUN tar -xzf factorio.tar.gz

RUN ["/opt/factorio/bin/x64/factorio", "--create", "save.zip"]

WORKDIR /opt/factorio

CMD ["/opt/factorio/bin/x64/factorio", "--disallow-commands", "--start-server", "save.zip"]

EXPOSE 34197/udp

VOLUME "/opt/factorio/saves"

