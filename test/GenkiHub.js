const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("GenkiHub contract", function () {
  it("Deployment should also deploy the QuestNFT contract", async function () {
    const [owner] = await ethers.getSigners();
    const GenkiHub = await ethers.getContractFactory("GenkiHub");
    const genkiHub = await GenkiHub.deploy();
    await genkiHub.deployed();

    const questAddr = await genkiHub.getQuestAddr();
    const QuestNFT = await ethers.getContractFactory("QuestNFT");
    const questNFT = await QuestNFT.attach(questAddr);
    expect(await questNFT.totalSupply()).to.equal(0);
  });
});
