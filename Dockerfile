FROM perl:latest

RUN apt update && apt install -y zsh && apt clean

COPY root/.zsh* /root

ENTRYPOINT ["/bin/zsh"]
