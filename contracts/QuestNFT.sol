// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./interfaces/IQuestNFT.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract QuestNFT is IQuestNFT, ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    mapping(uint256 => address) private _channelAddrs;

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("GenkiQuest", "GQT") {}

    function safeMint(address to, string memory uri) public onlyOwner returns (uint256) {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
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

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(IQuestNFT, ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(IQuestNFT, ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function setChannelAddr(uint256 questId, address channelAddr)
        external
        onlyOwner
    {
        _channelAddrs[questId] = channelAddr;
    }

    function getChannelAddr(uint256 questId) external view returns (address) {
        return _channelAddrs[questId];
    }
}
