// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
contract BeggingContract {
    mapping(address donate => uint256 amount) public donations;
    address public _owner;

    event donateEvent(address indexed donor, uint256 amount);

    constructor(address ownerAddress) {
        _owner = ownerAddress;
    }

//允许用户向合约发送以太币，并记录捐赠信息。
    function donate() public payable returns (bool) {
        require(msg.value > 0, "donate amouint should greater than 0");
        donations[msg.sender] += msg.value;
        return true;
    }

//允许合约所有者提取所有资金。
    function withdraw(uint256 amount) public returns (bool) {
        require(msg.sender == _owner, "Only Onwer can withdraw");
        require(address(this).balance >= 0, "no enough amount to withdraw");
        require(amount >= 0, "withdraw amount should greater than 0");
        // payable(_owner).transfer(address(this).balance);
         (bool success, ) = _owner.call{value: amount}("");
         require(success, "ETH transfer failed");
        return true;
    }

//查询某个地址的捐赠金额。
    function getDonation() public view returns (uint256) {
        return donations[msg.sender];
    }
    //捐赠排行榜：实现一个功能，显示捐赠金额最多的前 3 个地址。
    //加一个数组，存储所有的地址。调用排行榜的函数时遍历这个数组查到最高的三个金额，返回
}