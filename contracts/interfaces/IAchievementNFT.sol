// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IAchievementNFT {
    function safeMint(address to) external;
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    function getQuestId() external view returns (uint256);
    function getChannelId() external view returns (uint256);
}
