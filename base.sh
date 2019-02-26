#!/bin/bash

GITHUB_DIR=/Code/github.com
SYS_CONTRACTS_DIR=${GITHUB_DIR}/EOSIO/eosio.contracts/build
CONTRACTS_DIR=./contracts/build


EOSIO_DATA_DIR=~/eosio_data
WALLET_DIR=${EOSIO_DATA_DIR}/eosio-wallet


new_keys(){
    str=`cleos create key --to-console`
    pri_key=`echo $str | cut -d' ' -f 3`
    pub_key=`echo $str | cut -d' ' -f 6`
}

# usage: import_key <private key>
import_key(){
    cleos wallet import --private-key $1
}

# usage: create_account_by_name <eosio name>
create_account_by_name(){
    new_keys
    cleos system newaccount \
        --stake-net "1000.0000 EOS" --stake-cpu "1000.0000 EOS" --buy-ram "1000.0000 EOS" \
        firstaccount $1 $pub_key $pub_key -p firstaccount
    cleos transfer firstaccount $1 "100.0000 EOS"
    import_key $pri_key
}

# usage: create_account_by_name <eosio name> <publick key>
create_account_by_name_pubkey(){
    name=$1
    pub_key=$2
    cleos system newaccount \
        --stake-net "1000.0000 EOS" --stake-cpu "1000.0000 EOS" --buy-ram "1000.0000 EOS" \
        firstaccount $name $pub_key $pub_key -p firstaccount
    cleos transfer firstaccount $1 "100.0000 EOS"
}
