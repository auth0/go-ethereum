#!/bin/bash
set -vx
/root/go-ethereum/build/bin/geth geth --rpc --rpcaddr "0.0.0.0" --rpccorsdomain "*" --testnet
