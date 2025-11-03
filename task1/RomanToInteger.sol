// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract RomanToInteger {
    
     // 罗马字符 => 数值 的映射
    mapping(bytes32 => uint) public romanToIntMap;

    // 构造函数：初始化罗马字符映射表
    constructor() {
        romanToIntMap['I'] = 1;
        romanToIntMap['V'] = 5;
        romanToIntMap['X'] = 10;
        romanToIntMap['L'] = 50;
        romanToIntMap['C'] = 100;
        romanToIntMap['D'] = 500;
        romanToIntMap['M'] = 1000;
    }

    /// @notice 将罗马数字字符串转换为整数
    /// @param s 输入的罗马数字字符串，比如 "MCMXCIV"
    /// @return 对应的整数值
    function romanToInt(string memory s) public view returns (uint) {
        bytes memory romanBytes = bytes(s); // 将 string 转为 bytes，方便按索引访问
        uint total = 0;
        uint n = romanBytes.length;
        uint currentNums = 0;

        for (uint i = 0; i < n; i++) {
            bytes32 currentChar = romanBytes[i];
            uint currentValue = romanToIntMap[currentChar];

            // 如果不是最后一个字符，且当前值 < 下一个值
            if (i < n - 1) {
                bytes32 nextChar = romanBytes[i + 1];
                uint nextValue = romanToIntMap[nextChar];

                if (currentValue < nextValue) {
                    currentNums =nextValue- currentValue; // 如 IV = 4，即 5 - 1 => 减 1
                    continue;
                }
            }

            total += currentNums; // 正常情况，直接加
        }

        return total;
    }
}