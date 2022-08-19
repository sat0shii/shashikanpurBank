// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const [user1, user2, user3] = await hre.ethers.getSigners();
  const Token = await hre.ethers.getContractFactory("tokenA");
  const token = await Token.deploy("shashi", "shashikanpur");

  await token.deployed();
  await token.balance(user2.address)
  // console.log("contract of tokenA deployed at ", token.address);
  // console.log(await token.name());
  await token.connect(user1).mint(100);
  // await token.transfer(user1.address, user2.address, 20);
  // console.log((await token.balance(user1.address)).toNumber());
  // console.log((await token.balance(user2.address)).toNumber());
  // await token.connect(user2).transfer(user2.address, user3.address, 10);
  // console.log((await token.balance(user3.address)).toNumber());
  console.log("before", await token.balance(user1.address));
  console.log("before", await token.balance(user2.address));
  console.log("before", await token.balance(user3.address));
  await token.connect(user1).approve(user2.address, 5);
  console.log(await token.allowance(user1.address, user2.address));
  await token.connect(user2).transferFrom(user1.address, user3.address, 5);
  console.log("after", await token.balance(user1.address));
  console.log("after", await token.balance(user2.address));
  console.log("after", await token.balance(user3.address));
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
