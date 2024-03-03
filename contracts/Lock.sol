// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Lock {
    uint public value;

    event IncrementedValue(uint newValue);

    constructor(uint _initialValue) {
        value = _initialValue;
    }

    function incrementValue() public {
        value += 1;
        emit IncrementedValue(value);
    }
}
