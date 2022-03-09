const { ethers } = require("hardhat");

async function main() {
  // We get the contract to deploy
  const GenkiHub = await ethers.getContractFactory("GenkiHub");
  const genkiHub = await GenkiHub.deploy();
  console.log("GenkiHub deployed to:", genkiHub.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });