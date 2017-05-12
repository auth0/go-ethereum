FROM golang:latest
WORKDIR /root/
RUN apt-get update && apt-get install -y git build-essential libgmp3-dev  
RUN echo force update to 1.6.1
RUN git clone https://github.com/ethereum/go-ethereum
RUN (cd go-ethereum && git reset --hard v1.6.1)
RUN (cd go-ethereum && make geth)
ENV EN EN
ENV TERM=xterm-256color
RUN apt-get -y install curl
RUN apt-get -y install moreutils
ADD start.sh /start.sh
RUN chmod +x /start.sh
RUN tr -d '\r' < /start.sh > /start2.sh
RUN rm /start.sh
RUN mv /start2.sh /start.sh
ADD mining_script.js mining_script.js
RUN curl https://www.rinkeby.io/rinkeby.json > genesis_block.json
EXPOSE 8545
EXPOSE 30303
