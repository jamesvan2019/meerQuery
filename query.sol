// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.3;

import  "./meer.sol";

import "./blake2b.sol";

interface IMeerLock {
    struct BurnDetail {
        uint256 Amount;
        uint256 Time;
        uint256 Order;
        uint256 Height;
    }
    // query count
    function meerMappingCount(bytes memory _qngHash160) external view returns (uint256);

    // query amount
    function queryAmount(bytes memory _qngHash160) external view returns (uint256);

    // query burn detail
    function queryBurnDetails(bytes memory _qngHash160) external view returns (BurnDetail[] memory) ;
}

contract MeerReleaseQuery is BLAKE2b{

    IMeerLock constant public meerLock = IMeerLock(0x1000000000000000000000000000000000000000);

    function toBytes(bytes32 _data) public pure returns (bytes memory) {
        return abi.encodePacked(_data);
    }

    // query lock meer
    function query(bytes memory _pubkey) external view returns(uint256){
        bytes32 h = blake2b_256(_pubkey);
        bytes memory _qngHash160 =  CheckBitcoinSigs.p2wpkhFromPubkey(toBytes(h));
        return meerLock.queryAmount(_qngHash160);
    }
    
}