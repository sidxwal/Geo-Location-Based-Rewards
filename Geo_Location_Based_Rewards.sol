// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GeoReward {
    struct CheckIn {
        uint256 timestamp;
        uint256 reward;
    }

    mapping(address => CheckIn) public checkIns;
    mapping(address => uint256) public rewards;

    event CheckedIn(address indexed user, uint256 reward);
    event RewardClaimed(address indexed user, uint256 amount);

    function checkIn(uint256 latitude, uint256 longitude) public {
        require(latitude != 0 && longitude != 0, "Invalid location");

        uint256 rewardAmount = 10; // Static reward for simplicity
        checkIns[msg.sender] = CheckIn(block.timestamp, rewardAmount);
        rewards[msg.sender] += rewardAmount;

        emit CheckedIn(msg.sender, rewardAmount);
    }

    function claimReward() public {
        uint256 amount = rewards[msg.sender];
        require(amount > 0, "No rewards to claim");

        rewards[msg.sender] = 0; // Reset reward after claiming
        emit RewardClaimed(msg.sender, amount);
    }

    function getUserReward(address user) public view returns (uint256) {
        return rewards[user];
    }
}
