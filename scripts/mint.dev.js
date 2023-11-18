var InternetProtocol = artifacts.require("../contracts/InternetProtocol.sol");

module.exports = async (config) => {
    let instance = await InternetProtocol.deployed();
    let accounts = await web3.eth.getAccounts();

    let ids = [2130706433, 10, 2063663361];
    for (const i in ids) {
        instance.safeMint(accounts[0], ids[i], {from: accounts[0]});
    }

}