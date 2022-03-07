// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract AchievementNFT is ERC721, ERC721Enumerable, Ownable {
    uint256 private _questId;
    uint256 private _channelId;

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor(uint256 questId, uint256 channelId)
        ERC721("GenkiAchievement", "GAC")
    {
        _questId = questId;
        _channelId = channelId;
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
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
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function getQuestId() external view returns (uint256) {
        return _questId;
    }

    function getChannelId() external view returns (uint256) {
        return _channelId;
    }
}
