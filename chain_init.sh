#!/usr/bin/env bash

. ./base.sh

start_keosd(){
    killall keosd 2>/dev/null
    rm -rf ${WALLET_DIR}
    mkdir -p ${WALLET_DIR}
    nohup keosd --wallet-dir ${WALLET_DIR} --unlock-timeout 90000 1>/dev/null  2>/dev/null &
}
start_keosd

create_wallet(){
    rm -rf ~/eosio-wallet/
    cleos wallet create -f ${WALLET_DIR}/password.txt
    cleos wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
}
create_wallet

setup_system_contracts_and_issue_token(){
    # step 1: set contract eosio.bios
    cleos set contract eosio ${SYS_CONTRACTS_DIR}/eosio.bios -p eosio

    # step 2: create system accounts
    sleep .3
    for account in eosio.bpay eosio.msig eosio.names eosio.ram eosio.ramfee \
                   eosio.saving eosio.stake eosio.token eosio.vpay
    do
        echo -e "\n creating $account \n";
        cleos create account eosio ${account} EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV -p eosio -x 1000
        sleep .2
    done

    # step 3: set contract
    echo step 3
    cleos set contract eosio.token ${SYS_CONTRACTS_DIR}/eosio.token -p eosio.token
    cleos set contract eosio.msig ${SYS_CONTRACTS_DIR}/eosio.msig -p eosio.msig

    # step 4: create and issue token
    echo step 4
    cleos push action eosio.token create '["eosio", "10000000000.0000 EOS"]' -p eosio.token
    cleos push action eosio.token issue '["eosio",  "1000000000.0000 EOS", "EOSIO IS GREAT"]' -p eosio

    #setp 5: setting privileged account for eosio.msig
    cleos push action eosio setpriv '{"account": "eosio.msig", "is_priv": 1}' -p eosio

    # step 6: set contract eosio.system
    cleos set contract eosio ${SYS_CONTRACTS_DIR}/eosio.system -x 1000 -p eosio
    cleos push action eosio init '[0, "4,EOS"]' -p eosio

}
setup_system_contracts_and_issue_token

sleep .2

create_firstaccount(){
    echo "create first user account."
    new_keys
    cleos system newaccount \
         --stake-net "10000.0000 EOS" --stake-cpu "10000.0000 EOS" --buy-ram "10000.0000 EOS" \
         eosio firstaccount $pub_key $pub_key -p eosio --transfer
    cleos transfer eosio firstaccount "1000000.0000 EOS"
    import_key $pri_key
}
create_firstaccount

