const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("NFTModule", (m) => {
  const nft = m.contract("CoreNFT", [
    "https://0xkriswebchain.github.io/NFT-Collection-Dapp-Core/generated_metadata/",
  ]);

  return { nft };
});
