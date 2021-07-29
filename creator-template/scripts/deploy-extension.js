require('dotenv').config();

const { PUBLIC_KEY } = process.env;

async function main() {
  const SatellitesSoundsBeyondSight = await ethers.getContractFactory("SSBSTest");
  
  // Start deployment, returning a promise that resolves to a contract object
  const satellitesSoundsBeyondSight = await SatellitesSoundsBeyondSight.deploy(PUBLIC_KEY);
  console.log("Contract deployed to address:", satellitesSoundsBeyondSight.address);
}

main()
 .then(() => process.exit(0))
 .catch(error => {
   console.error(error);
   process.exit(1);
 });