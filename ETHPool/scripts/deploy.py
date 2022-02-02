from brownie import config, EthereumPool, network
from scripts.helpful_script import get_account, LOCAL_BLOCKCHAIN_ENVIRONMENTS


def deploy_eth_pool():
    # La siguiente función obtiene la cuenta que realizará el deploy del contrato.
    account = get_account()

    # Deploy del contrato.
    eth_pool = EthereumPool.deploy(
        # Se define la cuenta encargada de realizar el deploy
        {"from": account},
        # Si estamos en una red local, se verifica el contrato. De lo contrario, no.
        publish_source=config["networks"][network.show_active()].get("verify"),
    )
    print(f"Contract deployed to {eth_pool.address}")
    return eth_pool


def main():
    deploy_eth_pool()
