// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IChannelNFT {
    function safeMint(address to) external returns (uint256);
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    function getQuestId() external view returns (uint256);
    function setAchievementAddr(uint256 channelId, address achievementAddr) external;
    function getAchievementAddr(uint256 channelId) external view returns (address);
    function setConfirmed(address userAddr, bool confirmed) external;
    function getConfirmed(address userAddr) external view returns (bool);
}
