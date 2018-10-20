FROM golang:latest

WORKDIR /root/

RUN apt-get update && \
    apt-get install -y \
    git \
    build-essential \
    libgmp3-dev \
    curl \
    moreutils
    
RUN echo force update to 1.6.1

RUN git clone https://github.com/ethereum/go-ethereum && \
    (cd go-ethereum && git reset --hard v1.6.1) && \
    (cd go-ethereum && make geth)

ENV EN EN \
    TERM=xterm-256color

COPY start.sh /start.sh

RUN chmod +x /start.sh && \
    tr -d '\r' < /start.sh > /start2.sh && \
    rm /start.sh && \
    mv /start2.sh /start.sh
    
RUN curl https://www.rinkeby.io/rinkeby.json > genesis_block.json

EXPOSE 8545 30303
