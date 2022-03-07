const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("QuestNFT contract", function() {
    it("Mint 10 Quest NFTs", async function() {
        const [owner] = await ethers.getSigners();
        const QuestNFT = await ethers.getContractFactory("QuestNFT");
        const questNFT = await QuestNFT.deploy();
        await questNFT.deployed();

        const num = 10;
        const tokenURI = "https://quest.token.uri";
        for (let i = 0; i < num; i++) {
            await questNFT.safeMint(owner.address, tokenURI);
            expect(await questNFT.ownerOf(i)).to.equal(owner.address);
        }
        expect(await questNFT.balanceOf(owner.address)).to.equal(num);
    });
});
