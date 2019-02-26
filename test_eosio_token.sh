#!/usr/bin/env bash

. ./base.sh

contract=mytoken33333
contract_folder=eosio.token

keypair_1_prikey=5JfCFmHKKzGeJzEFmnzgwESQDyz4NXYyyMogxSvnYT1JaMYpJmG
keypair_1_pubkey=EOS6tpJ5WzqWde2nKUQYmfPRVmoUHFmCdtKG25RkQqWEaBFgTavE7

create_some_account(){
    create_account_by_name_pubkey ${contract} ${keypair_1_pubkey}
    import_key ${keypair_1_prikey}
}
create_some_account

set_contract(){
    cleos set contract ${contract} ${CONTRACTS_DIR}/${contract_folder} -x 1000 -p ${contract}
}
set_contract


echo  -------------------- ACTIONS TEST ------------------------

action_create(){
    cleos push action eosio.token create '["eosio", "10000000000.0000 EOS"]' -p eosio.token
}

action_issue(){
    cleos push action eosio.token issue '["eosio",  "1000000000.0000 EOS", "memo"]' -p eosio
}

action_transfer(){
    echo
}



actions_test(){
    action_hi
}
actions_test



