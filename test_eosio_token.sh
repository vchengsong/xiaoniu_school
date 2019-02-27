#!/usr/bin/env bash

. ./base.sh

contract=mytoken33333
contract_folder=eosio.token

keypair_1_prikey=5JfCFmHKKzGeJzEFmnzgwESQDyz4NXYyyMogxSvnYT1JaMYpJmG
keypair_1_pubkey=EOS6tpJ5WzqWde2nKUQYmfPRVmoUHFmCdtKG25RkQqWEaBFgTavE7

issuer=mytoken11111
user1=eosiouser111
user2=eosiouser112

create_some_account(){
    create_account_by_name_pubkey ${contract} ${keypair_1_pubkey}
    import_key ${keypair_1_prikey}

    create_account_by_name ${issuer}
    create_account_by_name ${user1}
    create_account_by_name ${user2}
}
create_some_account

set_contract(){
    cleos set contract ${contract} ${CONTRACTS_DIR}/${contract_folder} -x 1000 -p ${contract}
}
set_contract


echo  -------------------- ACTIONS TEST ------------------------

action_create(){
    cleos push action ${contract} create '["'${contract}'", "1000000.0000 GOLD"]' -p ${contract}

    cleos get table ${contract} GOLD stat
    cleos get currency balance ${contract} ${contract} GOLD
    cleos get currency balance eosio.token ${contract} EOS
}

action_issue(){
    cleos push action ${contract} issue '["'${contract}'", "100000.0000 GOLD", "memo"]' -p ${contract}

    cleos get table ${contract} GOLD stat
    cleos get currency balance ${contract} ${contract} GOLD
}

action_transfer(){
    cleos get currency balance ${contract} ${user1} GOLD
    cleos get currency balance ${contract} ${user2} GOLD

    cleos push action ${contract} transfer '["'${contract}'", '${user1}', "100.0000 GOLD", "memo"]' -p ${contract}

    cleos push action ${contract} transfer '["'${user1}'", '${user2}', "10.0000 GOLD", "memo"]' -p ${user1}
}


actions_test(){
    echo
}
actions_test



