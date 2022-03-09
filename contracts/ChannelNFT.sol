// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./interfaces/IChannelNFT.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ChannelNFT is IChannelNFT, ERC721, ERC721Enumerable, Ownable {
    uint256 private _questId;
    mapping(uint256 => address) private _achievementAddrs;
    mapping(address => bool) private _confirmedUserAddrs;

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor(uint256 questId) ERC721("GenkiChannel", "GCN") {
        _questId = questId;
    }

    function safeMint(address to) public onlyOwner returns (uint256) {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        return tokenId;
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(IChannelNFT, ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function getQuestId() external view returns (uint256) {
        return _questId;
    }

    function setAchievementAddr(uint256 channelId, address achievementAddr)
        external
        onlyOwner
    {
        _achievementAddrs[channelId] = achievementAddr;
    }

    function getAchievementAddr(uint256 channelId)
        external
        view
        returns (address)
    {
        return _achievementAddrs[channelId];
    }

    function setConfirmed(address userAddr, bool confirmed) external {
        _confirmedUserAddrs[userAddr] = confirmed;
    }

    function getConfirmed(address userAddr) external view returns (bool) {
        return _confirmedUserAddrs[userAddr];
    }
}
