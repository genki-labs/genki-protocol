// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IQuestNFT {
    function safeMint(address to, string memory uri) external returns (uint256);
    function tokenURI(uint256 tokenId) external view returns (string memory);
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    function setChannelAddr(uint256 questId, address channelAddr) external;
    function getChannelAddr(uint256 questId) external view returns (address);
}
