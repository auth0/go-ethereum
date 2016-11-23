#!/bin/bash
set -vx
echo gft > password
/root/go-ethereum/build/bin/geth init genesis_block.json
/root/go-ethereum/build/bin/geth --password password account new
#Building static_nodes.json from the ips/ids

NODE_KEY_HEX=`cat /dev/urandom | tr -cd 'a-f0-9' | head -c 64`



/root/go-ethereum/build/bin/geth --fakepow --forcejit --lightkdf --password password --rpccorsdomain "*" --cache=4096 --jitcache "64" --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --rpcaddr 0.0.0.0 --unlock 0 --nodiscover --nodekeyhex $NODE_KEY_HEX --fast --port 30303 --networkid 1123 --rpc --rpcport 8545 --verbosity 1 --maxpeers 200 js mining_script.js