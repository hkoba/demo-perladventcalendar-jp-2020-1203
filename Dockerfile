FROM perl:latest

RUN apt-get update && apt-get install -y zsh && apt-get clean

COPY root/.zsh* /root

RUN mkdir /data
VOLUME /data
WORKDIR /data

# https://qiita.com/youtyan/items/ffc7ce5ef9d0818094ad
# +
# https://serverfault.com/questions/362903/how-do-you-set-a-locale-non-interactively-on-debian-ubuntu
RUN apt-get update && \
  apt-get install -y locales && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    dpkg-reconfigure -f noninteractive locales && \
    /usr/sbin/update-locale LANG=ja_JP.UTF-8 && \
  apt-get clean

ENV LC_ALL ja_JP.UTF-8

COPY demo1 /data/demo1
COPY demo3 /data/demo3

RUN cd /data/demo3 && curl -sL https://git.io/cpm | perl - install -g --show-build-log-on-failure

ENTRYPOINT ["/bin/zsh"]
