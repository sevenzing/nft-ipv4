network := env_var_or_default("NETWORK_NAME", "development")

migrate-verify:
    just migrate
    just mint &
    just verify
    
migrate:
    truffle migrate --network {{network}}

verify:
    truffle run verify InternetProtocol --network {{network}} --verifiers=etherscan --debug

mint:
    truffle exec scripts/mint.dev.js --network {{network}}
