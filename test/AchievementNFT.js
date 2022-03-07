const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("AchievementNFT contract", function () {
  it("Mint 10 Achievement NFTs", async function () {
    const [owner] = await ethers.getSigners();
    const AchievementNFT = await ethers.getContractFactory("AchievementNFT");
    const achievementNFT = await AchievementNFT.deploy(0, 0);
    await achievementNFT.deployed();

    const num = 10;
    for (let i = 0; i < num; i++) {
      await achievementNFT.safeMint(owner.address);
      expect(await achievementNFT.ownerOf(i)).to.equal(owner.address);
    }
    expect(await achievementNFT.balanceOf(owner.address)).to.equal(num);
  });
});
