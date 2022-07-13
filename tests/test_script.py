from brownie import network, config, accounts, Contract, interface, Whitelist  
from web3 import Web3

def encode_leaf(address, spot_count):
    