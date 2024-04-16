-include .env

.PHONY: all clean deploy help install snapshot format anvil 

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

help:
	@echo "make deploy [ARGS=....]"

build:; forge build

install:; forge install

# Clean the repo
clean  :; forge clean

all: clean remove install update build

snapshot :; forge snapshot

format :; forge fmt

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

# if --network fantom is used then use fantom network config 
ifeq ($(findstring --network fantom,$(ARGS)),--network fantom)
	NETWORK_ARGS := --rpc-url $(FANTOM_RPC_URL) --private-key $(PRIVATE_KEY) --slow --broadcast --verify --verifier-url https://api-testnet.ftmscan.com/api/ --etherscan-api-key $(FANTOM_API_KEY) -vvvv
endif

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(SEPOLIA_PRIVATE_KEY) --slow  --broadcast --verify --verifier-url https://api-sepolia.etherscan.io/api --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy vault:
	forge script script/Deploy/DeployVault.s.sol:DeployVault $(NETWORK_ARGS)

