// SPDX-License-Identifier: MIT
pragma solidity 0.8;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract NftAuctionV2 is Initializable {
    struct Auction {
        address seller;
        uint256 startTime;
        // 持续时间
        uint256 duration;
        // 起始价格
        uint256 startPrice;
        
        // higets price
        uint256 highestBid;
        // higest price adress
        address highestBidder;
        // is ended
        bool isActive;

        // NFT info
        address nftAddress;
        uint256 tokenId;
    }

    mapping(uint256 => Auction) public auctions;

    uint256 public nextAuctionId;
    address public admin;

    function initialize() public initializer {
        admin = msg.sender;
    }

    function createAuction(uint256 _duration, uint256 _startPrice, address _nftAddress, uint256 _tokenId) public {
        require(msg.sender == admin, "only admin can create auction");
        require(_duration > 1000 * 60, "duration should be greater than 1 minute");
        require(_startPrice > 0, "start price should be greater than 0");
        auctions[nextAuctionId] = Auction(
            msg.sender, 
            block.timestamp, 
            _duration, _startPrice, 
            0, address(0), 
            false, 
            _nftAddress,
             _tokenId
             );
        nextAuctionId++;
    }
    
    // 买家参与拍卖
    function placeBid(uint256 _auctionId) public payable {
        Auction storage auction = auctions[_auctionId];
        require(!auction.isActive && block.timestamp < auction.startTime + auction.duration, "auction has ended");
        require(msg.value > auction.highestBid && msg.value >= auction.startPrice, "there already is a higher bid");
        // 如果有之前的最高出价，退还给之前的最高出价者
        if (auction.highestBidder != address(0)) {
            payable(auction.highestBidder).transfer(auction.highestBid);
        }
            
        // 更新最高出价和最高出价者
        auction.highestBid = msg.value;
        auction.highestBidder = msg.sender;
    }

    function testHello() public pure returns (string memory) {
        return "Hello, this is NftAuctionV2!";

    }
}
