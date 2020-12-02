FROM perl:latest

RUN apt-get update && apt-get install -y zsh && apt-get clean

COPY root/.zsh* /root

RUN mkdir /data
VOLUME /data
WORKDIR /data

COPY demo1 /data/demo1
COPY demo3 /data/demo3

RUN cd /data/demo3 && curl -sL https://git.io/cpm | perl - install -g --show-build-log-on-failure

ENTRYPOINT ["/bin/zsh"]
