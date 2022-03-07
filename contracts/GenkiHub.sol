// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./QuestNFT.sol";
import "./ChannelNFT.sol";
import "./AchievementNFT.sol";


/**
 * @title GenkiHub
 * @author Genki Protocol
 *
 * This is the main entry point of the Genki Protocol. It contains quest posting,
 * channel registering, and reward claming functionality.
 */
contract GenkiHub {
    address private immutable OWNER_ADDR;
    address private immutable QUEST_NFT_ADDR;

    mapping(uint256 => address) private _channelNFTAddrs;
    mapping(uint256 => uint256) private _questRewards;
    mapping(address => uint256) private _channelRewards;

    constructor() {
        QuestNFT questNFT = new QuestNFT();
        QUEST_NFT_ADDR = address(questNFT);
        OWNER_ADDR = msg.sender;
    }

    function postQuest(string memory uri) external payable {
        require(
            msg.value <= msg.sender.balance,
            "GenkiHub: insufficient balance for quest reward"
        );
        QuestNFT questNFT = QuestNFT(QUEST_NFT_ADDR);
        uint256 questId = questNFT.safeMint(msg.sender, uri);
        ChannelNFT channelNFT = new ChannelNFT(questId);
        questNFT.setChannelAddr(questId, address(channelNFT));
        registerChannel(0, OWNER_ADDR); // channel_id 0 is the non-referral channel
        _questRewards[questId] = msg.value;
    }

    function registerChannel(uint256 questId) public {
        registerChannel(questId, msg.sender);
    }

    function registerChannel(uint256 questId, address to) private {
        QuestNFT questNFT = QuestNFT(QUEST_NFT_ADDR);
        require(questId < questNFT.totalSupply(), "GenkiHub: invalid quest id");
        ChannelNFT channelNFT = ChannelNFT(questNFT.getChannelAddr(questId));
        uint256 channelId = channelNFT.safeMint(to);
        AchievementNFT achievementNFT = new AchievementNFT(questId, channelId);
        channelNFT.setAchievementAddr(channelId, address(achievementNFT));
    }

    function confirm(
        uint256 questId,
        uint256 channelId,
        address userAddr
    ) external {
        QuestNFT questNFT = QuestNFT(QUEST_NFT_ADDR);
        require(questId < questNFT.totalSupply(), "GenkiHub: invalid quest id");
        ChannelNFT channelNFT = ChannelNFT(questNFT.getChannelAddr(questId));
        require(
            channelId < channelNFT.totalSupply(),
            "GenkiHub: invalid channel id"
        );
        uint256 reward = _questRewards[questId];
        _questRewards[questId] -= reward;
        _channelRewards[channelNFT.ownerOf(channelId)] += reward;
        channelNFT.setConfirmed(userAddr, true);
    }

    function dispute(
        uint256 questId,
        uint256 channelId,
        address userAddr
    ) external {
        QuestNFT questNFT = QuestNFT(QUEST_NFT_ADDR);
        require(questId < questNFT.totalSupply(), "GenkiHub: invalid quest id");
        ChannelNFT channelNFT = ChannelNFT(questNFT.getChannelAddr(questId));
        require(
            channelId < channelNFT.totalSupply(),
            "GenkiHub: invalid channel id"
        );
        channelNFT.setConfirmed(userAddr, false);
    }

    function withdraw() external {
        payable(msg.sender).transfer(_channelRewards[msg.sender]);
        _channelRewards[msg.sender] = 0;
    }

    function claim(uint256 questId, uint256 channelId) external {
        QuestNFT questNFT = QuestNFT(QUEST_NFT_ADDR);
        require(questId < questNFT.totalSupply(), "GenkiHub: invalid quest id");
        ChannelNFT channelNFT = ChannelNFT(questNFT.getChannelAddr(questId));
        require(
            channelId < channelNFT.totalSupply(),
            "GenkiHub: invalid channel id"
        );
        require(
            channelNFT.getConfirmed(address(msg.sender)),
            "GenkiHub: the user is not confirmed yet"
        );
        AchievementNFT achievementNFT = AchievementNFT(
            channelNFT.getAchievementAddr(channelId)
        );
        achievementNFT.safeMint(msg.sender);
    }

    function getQuestAddr() public view returns (address) {
        return QUEST_NFT_ADDR;
    }
}
