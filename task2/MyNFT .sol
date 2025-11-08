// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    uint256 public _tokenIdCounter;

    // 构造函数：初始化 NFT 名称和符号，tokenCounter 从 0 开始
    constructor() ERC721("CA_Nft", "CAT") Ownable(msg.sender) {}

    // mintNFT 函数：只有合约拥有者可以调用，传入接收者地址和元数据链接
   function mintNFT(address recipient, string memory tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        unchecked { _tokenIdCounter++; }        // 原生自增，节省 gas
        uint256 tokenId = _tokenIdCounter;      // 与旧 Counters 行为一致：从 1 开始
        _safeMint(recipient, tokenId);
        _setTokenURI(tokenId, tokenURI);
        return tokenId; 
    }
}