async function main() {
    // Grab the contract factory 
    const SSCFactory = await ethers.getContractFactory("SSC");
    
    // Start deployment, returning a promise that resolves to a contract object
    const SSC = await SSCFactory.deploy(); // Instance of the contract 
    console.log("Contract deployed to address:", SSC.address);
 }
 
 main()
   .then(() => process.exit(0))
   .catch(error => {
     console.error(error);
     process.exit(1);
   });