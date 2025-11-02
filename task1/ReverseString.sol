// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/**
题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
*/
contract ReverseString{
    function reverseString(string memory input) public pure returns (string memory) {
        bytes memory bytesInput = bytes(input);
        uint length = bytesInput.length;
        bytes memory reversedBytes = new bytes(length);
        for (uint i = 0; i < length; i++) {
            reversedBytes[i] = bytesInput[length - i - 1];
        }
        return string(reversedBytes);
    }
}