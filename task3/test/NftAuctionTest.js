const {ethers} = require("hardhat");

describe("NftAuctionTest", async function () {
    it("should be able to deploy", async function inner() {
        const NftAuction = await ethers.getContractFactory("NftAuction");
        const nftAuction = await NftAuction.deploy();
        await nftAuction.waitForDeployment();
        console.log("NftAuction deployed to:", nftAuction.address);

        await nftAuction.createAuction(600 * 1000, ethers.parseEther("0.000000000001"), ethers.ZeroAddress, 1);
        const auction = await nftAuction.auctions(0);
        console.log("Auction created:", auction);

    })
});
