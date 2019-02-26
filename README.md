
This project is designed to assist developers in building eosio smart-contract development environment.
The whole process is divided into three steps.   
1. start a single node eosio blockchain.  
2. create basic accounts and deploy eosio system contracts.  
3. build, deploy and test your own contract.  

### Prepare System Contracts
```bash
$ mkdir -p /Code/github.com/EOSIO
$ cd /Code/github.com/EOSIO
$ git clone https://github.com/EOSIO/eosio.contracts
$ cd eosio.contracts
$ ./build.sh
```

### Start One Node Blockchain
```bash
$ ./nodeos.sh         # start blockchain, and press 'Ctrl + C' to exit gracefully 
$ ./nodeos.sh re      # remove all existing block data, and start a new chain
$ ./nodeos.sh clear   # remove all existing block data
```

### Initialize Blockchain
```bash
$ . chain_init.sh
```

### Compile Your Contracts
```bash
$ cd contracts
$ ./build.sh
```

### Deploy and Test Your Contracts
```bash
$ . test_hello_world.sh
```


