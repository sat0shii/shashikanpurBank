const hre = require("hardhat");

async function main() {
  const[user1] = await hre.ethers.getSigners();
  const A = await hre.ethers.getContractFactory("tokenA");
  const a = await A.deploy("aman", "amanToken");
  await a.deployed();
  console.log("tokenA deployed at", a.address);
  const S = await hre.ethers.getContractFactory("tokenS");
  const s = await S.deploy("shashi", "shashiToken");
  await s.deployed();
  console.log("tokenS deployed at", a.address);
  const B = await hre.ethers.getContractFactory("sbank");
  const b = await B.deploy(a.address);
  await b.deployed();
  console.log("shashibank deployed at", a.address);
  
  await a.connect(user1).mint(500);
  //console.log(await a.balance(user1.address));
  await a.connect(user1).approve(b.address, 100);
  //console.log(await a.allowance(user1.address,b.address));
  console.log(await b.connect(user1).ledger(user1.address));
  await b.Deposit(100);
  console.log(await b.connect(user1).ledger(user1.address));
  await b.withdraw(50);
//   console.log(await b.connect(user1).ledger(user1.address));
//   console.log(await s.connect(user1).balance(user1.address));
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
