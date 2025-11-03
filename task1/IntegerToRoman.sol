// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/**罗马数字包含以下七种字符: I， V， X， L，C，D 和 M。

字符          数值
I             1
V             5
X             10
L             50
C             100
D             500
M             1000
uint[] public values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
string[] public symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
**/
contract IntegerToRoman{

    uint256[] public values = [
        1000, 900, 500, 400,
        100, 90, 50, 40,
        10, 9, 5, 4,
        1
    ];

    string[] public symbols = [
        "M", "CM", "D", "CD",
        "C", "XC", "L", "XL",
        "X", "IX", "V", "IV",
        "I"
    ];

    function intToRoman(uint num) public view returns (string memory) {
        bytes memory roman = new bytes(20);
        uint index = 0;

        for (uint i = 0; i < values.length; i++) {
            while (num >= values[i]) {
                string memory s = symbols[i];
                uint len = bytes(s).length;
                for (uint j = 0; j < len; j++) {
                    roman[index++] = bytes(s)[j];
                }
                num -= values[i];
            }
        }

        bytes memory result = new bytes(index);
        for (uint k = 0; k < index; k++) {
            result[k] = roman[k];
        }

        return string(result);
    }
}