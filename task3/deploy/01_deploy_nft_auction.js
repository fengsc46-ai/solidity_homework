const { deployments, upgrades, ethers } = require("hardhat");
const fs = require('fs');
const path = require('path');

// deploy/00_deploy_my_contract.js
module.exports = async ({getNamedAccounts, deployments}) => {
  const {save} = deployments;
  const {deployer} = await getNamedAccounts();

  console.log("Deploying MyContract with the account:", deployer);

  const NftAuction = await ethers.getContractFactory("NftAuction");

  const nftAuctionProxy = await upgrades.deployProxy(NftAuction, [], { 
    initializer: 'initialize' 
  });

  await nftAuctionProxy.waitForDeployment();

  const proxyAddress = await nftAuctionProxy.getAddress();
  const implAddress = await upgrades.erc1967.getImplementationAddress(proxyAddress);
  console.log("NftAuction Proxy deployed to:", proxyAddress);
  console.log("NftAuction implAddress deployed to:", implAddress);

  const storePath = path.resolve(__dirname, "./.cache/proxyAuction.json");
  fs.writeFileSync(
    storePath,
    JSON.stringify({ 
      proxyAddress, 
      implAddress, 
      abi: NftAuction.interface.format("json") 
    })
  );
  
  await save('NftAuctionProxy', {
    abi: NftAuction.interface.format("json"),
    address: proxyAddress,
    // args: [],
    // log: true,
  });
  
  // await deploy('MyContract', {
  //   from: deployer,
  //   args: ['Hello'],
  //   log: true,
  // });
};
module.exports.tags = ['deployNFTAuction'];