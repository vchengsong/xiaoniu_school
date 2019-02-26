
This project is designed to assist developers in building eosio smart-contract development environment.
The whole process is divided into three steps.   
1. start a single node eosio blockchain.  
2. create basic accounts and deploy eosio system contracts.  
3. build, deploy and test your own contract.  

### 1. Prepare System Contracts
```bash
$ mkdir -p /Code/github.com/EOSIO
$ cd /Code/github.com/EOSIO
$ git clone https://github.com/EOSIO/eosio.contracts
$ cd eosio.contracts
$ ./build.sh
```

### 2. Start Single-node Blockchain
```bash
$ ./nodeos.sh         # start blockchain, press 'Ctrl + C' to exit gracefully 
$ ./nodeos.sh re      # remove all existing block data, then start a new chain
$ ./nodeos.sh clear   # remove all existing block data
```

### 3. Initialize Blockchain
```bash
$ . chain_init.sh
```

### 4. Compile Your Contracts
```bash
$ cd contracts
$ ./build.sh
```

### 5. Deploy and Test Your Contracts
```bash
$ . test_hello_world.sh
```


