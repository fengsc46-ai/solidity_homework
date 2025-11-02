// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/** 
给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。
可以使用 for 循环遍历数组，结合 if 条件判断和 map 数据结构来解决，例如通过 map 记录每个元素出现的次数，
然后再遍历 map 找到出现次数为1的元素。*/
contract SingleNumber{
    mapping (uint256 nums => uint256 counts) public collections ;

    function singleNumber(uint256[] memory nums) public returns (uint256 result) {
        
        for (uint i = 0; i < nums.length-1; i++) {
            uint256 value = nums[i];
            collections[value] += 1;
        }
        for (uint i = 0; i < nums.length-1; i++) {
             uint256 value = nums[i];
            if(collections[value] == 1){
                return value;
            }
        }
       revert("error");
    }
}