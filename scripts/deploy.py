from brownie import network, config, accounts, Contract, interface, WhitelistSale
from scripts.helpful_scripts import get_account


def main():
    account = get_account()
    nft = WhitelistSale.deploy(
        "71fbf5020c6e29ee301c90ec5b6af2611a969cfc17de1bbde7d6ef05f85fc842",
        {"from": account},
        publish_source=True,
    )
