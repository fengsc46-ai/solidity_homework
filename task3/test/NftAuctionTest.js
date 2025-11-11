const {ethers, deployments} = require("hardhat");
const { expect } = require("chai");

describe("NftAuctionTest", async function () {
    it("should be able to deploy", async function inner() {
        // const NftAuction = await ethers.getContractFactory("NftAuction");
        // const nftAuction = await NftAuction.deploy();
        // await nftAuction.waitForDeployment();
        // console.log("NftAuction deployed to:", nftAuction.address);

        // await nftAuction.createAuction(600 * 1000, ethers.parseEther("0.000000000001"), ethers.ZeroAddress, 1);
        // const auction = await nftAuction.auctions(0);
        // console.log("Auction created:", auction);

        // 创建合约
        await deployments.fixture(["deployNFTAuction"]);
        const nftAuctionProxy = await deployments.get("NftAuctionProxy");

        //创建拍卖
        const nftAuction = await ethers.getContractAt("NftAuction", nftAuctionProxy.address);
        await nftAuction.createAuction(600 * 1000, ethers.parseEther("0.000000000001"), ethers.ZeroAddress, 1);
        const auction = await nftAuction.auctions(0);
        console.log("Auction created:", auction);
        //升级合约

        await deployments.fixture(["upgradeNftAuction"]);
        //读取合约的状态变量
        const auctionV2 = await nftAuction.auctions(0);
        expect(auctionV2.startTime).to.equal(auction.startTime);

    })
});
