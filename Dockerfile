FROM ubuntu:latest

MAINTAINER zopanix@gmail.com

WORKDIR /opt

COPY ./factorio.tar.gz /opt

COPY ./smart_launch.sh /opt

RUN tar -xzf factorio.tar.gz

CMD ["./smart_launch.sh"]

EXPOSE 34197/udp

VOLUME "/opt/factorio/saves"

