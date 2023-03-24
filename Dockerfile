FROM ubuntu:18.04
RUN apt-get update && apt-get install -y autoconf automake curl cmake git libtool make \
    && git clone --depth=1 https://github.com/tsl0922/ttyd.git /ttyd \
    && cd /ttyd && env BUILD_TARGET=x86_64 ./scripts/cross-build.sh

FROM ubuntu:20.04
COPY --from=0 /ttyd/build/ttyd /usr/bin/ttyd

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y tini sudo screen wget curl mc netcat git vim htop bat less sqlite3 python3 python3-distutils

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 ubuntu
USER ubuntu
WORKDIR /home/ubuntu

EXPOSE 7681
COPY init.sh /home/ubuntu/init-ttyd.sh

ENTRYPOINT ["/usr/bin/tini", "--", "/home/ubuntu/init-ttyd.sh"]
CMD ["/home/ubuntu/init-ttyd.sh"]
