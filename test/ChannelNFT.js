const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ChannelNFT contract", function () {
  it("Mint 10 Channel NFTs", async function () {
    const [owner] = await ethers.getSigners();
    const ChannelNFT = await ethers.getContractFactory("ChannelNFT");
    const channelNFT = await ChannelNFT.deploy(0);
    await channelNFT.deployed();

    const num = 10;
    for (let i = 0; i < num; i++) {
      await channelNFT.safeMint(owner.address);
      expect(await channelNFT.ownerOf(i)).to.equal(owner.address);
    }
    expect(await channelNFT.balanceOf(owner.address)).to.equal(num);
  });
});
