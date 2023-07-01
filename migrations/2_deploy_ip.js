var IPDrawer = artifacts.require("IPDrawer");
var InternetProtocol = artifacts.require("InternetProtocol");

module.exports = function (deployer) {
    deployer.link(IPDrawer, InternetProtocol);
    deployer.deploy(InternetProtocol);
};