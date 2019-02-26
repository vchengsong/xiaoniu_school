#!/usr/bin/env bash

EOSIO_DIR=~/eosio_data

killall nodeos 2>/dev/null

if [[ "$1" == "clear" ]];then
    rm -rf ${EOSIO_DIR}/*
    exit 0
fi

if ! [[ -d $EOSIO_DIR ]];then
    mkdir ${EOSIO_DIR}
fi

# "re" means remove history blocks, and start a new chain
if [[ "$1" == "re" ]];then
    rm -rf ${EOSIO_DIR}/*
fi

nodeos -e -p eosio -d ${EOSIO_DIR}/data --config-dir ${EOSIO_DIR}/config  \
    --plugin eosio::chain_api_plugin --plugin eosio::producer_plugin  \
    --plugin eosio::producer_api_plugin --plugin eosio::history_api_plugin  \
    --contracts-console  --max-transaction-time 1000


