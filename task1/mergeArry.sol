// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract mergeArry {

    
    function mergeArrys(int[] calldata arry1, int[] calldata arry2) public pure returns (int[] memory) {
        int256[] memory mergedArray; // create a new array with the size of the two arrays combined
        uint len1 = arry1.length;
        uint len2 = arry2.length;

        uint i = 0; // 指向 array1 的索引
        uint j = 0; // 指向 array2 的索引
        uint k = 0; // 指向 mergedArray 的索引

         while (i < len1 && j < len2) {
            if (arry1[i] <= arry2[j]) {
                mergedArray[k] = arry1[i];
                i++;
            } else {
                mergedArray[k] = arry2[j];
                j++;
            }
            k++;
        }

        // 如果 array1 还有剩余元素，全部追加
        while (i < len1) {
            mergedArray[k] = arry1[i];
            i++;
            k++;
        }

        // 如果 array2 还有剩余元素，全部追加
        while (j < len2) {
            mergedArray[k] = arry2[j];
            j++;
            k++;
        }

        return mergedArray;
    }
}