require("@nomiclabs/hardhat-waffle");

task("demo", "Deploys the Genki Protocol", async ({ }, hre) => {
  const ethers = await hre.ethers;
  const [owner, addr1, addr2, addr3, addr4] = await ethers.getSigners();

  console.log("Deploying Genki Hub");
  const GenkiHub = await ethers.getContractFactory("GenkiHub");
  const genkiHub = await GenkiHub.deploy();
  await genkiHub.deployed();
  console.log(genkiHub.address);

  const QuestNFT = await ethers.getContractFactory("QuestNFT");
  const questAddr = await genkiHub.getQuestAddr();
  const questNFT = await QuestNFT.attach(questAddr);

  async function printBalance(signer, name) {
    let balance = await ethers.provider.getBalance(signer.address);
    balance = ethers.utils.formatEther(balance);
    console.log(`${signer.address} ${name}: ${balance}`);
  }

  async function printSnapshot() {
    console.log("------------------------------------");
    printBalance(genkiHub, "GenkiHub");
    printBalance(owner, "Genki Owner");
    printBalance(addr1, "Project Owner");
    printBalance(addr2, "Channel");
    printBalance(addr3, "Validator");
    printBalance(addr4, "User");
    let quest_num = await questNFT.totalSupply();
    console.log(`Quest number: ${quest_num}`);
    console.log("------------------------------------");
  }

  await printSnapshot();

  const reward = "100.0";
  await genkiHub.connect(addr1).postQuest(
    "https://api.genki.io/quest/1.json",
    {
      value: ethers.utils.parseEther(reward),
    },
  );
  console.log(`${addr1.address} posted a quest with reward ${reward}.`);
  await printSnapshot();

  await genkiHub.connect(addr2).registerChannel(0);
  console.log(`${addr2.address} registered a channel for quest 0.`);
  await printSnapshot();

  // The user saw the referral link.
  // The user participated in the quest.
  // The user completed the quest.

  await genkiHub.connect(addr3).confirm(0, 1, addr4.address);
  console.log(`${addr3.address} confirmed that ${addr4.address} has completed quest 0.`);
  await printSnapshot();

  await genkiHub.connect(addr2).withdraw();
  console.log(`${addr2.address} withdrawed the reward.`);
  await printSnapshot();

  await genkiHub.connect(addr4).claim(0, 1);
  console.log(`${addr4.address} claimed the badge.`);
  await printSnapshot();
});

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  networks: {
    hardhat: {
      gasPrice: 50000000000,
    },
  },
  solidity: {
    compilers: [
      {
        version: "0.8.12",
        settings: {
          optimizer: {
            enabled: true,
            runs: 1,
          },
        },
      },
    ],
  }
};
