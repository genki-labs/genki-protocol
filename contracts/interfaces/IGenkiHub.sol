// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IGenkiHub {
    function postQuest(string memory uri) external payable;
    function registerChannel(uint256 questId) external;
    function confirm(uint256 questId, uint256 channelId, address userAddr) external;
    function dispute(uint256 questId, uint256 channelId, address userAddr) external;
    function withdraw() external;
    function claim(uint256 questId, uint256 channelId) external;
    function getQuestAddr() external view returns (address);
}
