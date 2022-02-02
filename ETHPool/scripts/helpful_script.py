from brownie import network, accounts, config


LOCAL_BLOCKCHAIN_ENVIRONMENTS = [
    "development",
]

# 1) Si la cuenta que realiza el deploy esta en los ambientes locales,
# retornar la primera cuenta del vector de cuentas.
# 2) Caso contrario (testnet o mainnet) importar la cuenta desde config mediante PRIVATE_KEY.
def get_account():
    if network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])
