FROM ubuntu:xenial
WORKDIR /root/
RUN apt-get update && apt-get install -y git build-essential libgmp3-dev golang
RUN echo force update to 1.4.7 first go
RUN git clone https://github.com/ethereum/go-ethereum
RUN (cd go-ethereum && git reset --hard v1.4.18)
RUN (cd go-ethereum && make geth)
RUN mkdir ~/.ethash
RUN ./go-ethereum/build/bin/geth makedag 0 ~/.ethash
COPY genesis_block.json genesis_block.json
ENV TERM=xterm-256color
RUN apt-get -y install curl
RUN apt-get -y install moreutils
ADD start.sh /start.sh
RUN chmod +x /start.sh
RUN tr -d '\r' < /start.sh > /start2.sh
RUN rm /start.sh
RUN mv /start2.sh /start.sh
ADD mining_script.js mining_script.js
EXPOSE 8545
