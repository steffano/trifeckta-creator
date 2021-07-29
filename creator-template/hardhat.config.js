/**
* @type import('hardhat/config').HardhatUserConfig
*/
require('dotenv').config();
require('hardhat-contract-sizer');
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");

const { API_URL, PRIVATE_KEY } = process.env;

module.exports = {
   solidity: {
     version: "0.8.6",
     settings: {
       optimizer: {
        enabled: true,
        runs: 1}
     }
    },
   defaultNetwork: "rinkeby",
   networks: {
      hardhat: {},
      rinkeby: {
         url: API_URL,
         accounts: [`0x${PRIVATE_KEY}`]
      }
   },
   contractSizer: {
     alphasort: true,
     runOnCompile:true,
     disambiguatePaths: false,
   },
   etherscan: {
     apiKey: process.env.ETHERSCAN_API_KEY
   }
};