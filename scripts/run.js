const deployContract = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('JSNFT');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);
    const aiImages = [
      '{ "name": "JS-NFT-AI-ART", "description": "AI art created by JS-NFT", "image": "https://www.dropbox.com/s/toq98op6t8g9wts/AI-POST-WORD-1.jpeg?raw=1" }', 
      '{ "name": "JS-NFT-AI-ART-2", "description": "AI art created by JS-NFT", "image": "https://www.dropbox.com/s/o5h5f9deg7nm5cj/AI-POST-WORLD-2.jpeg?raw=1" }'
    ]

    let itemID = 0
    while(itemID <= aiImages.length - 1) {
      let txn = await nftContract.makeJSNFT()
      await txn.wait()
      // await await nftContract.setBase64NFTData('{ "name": "JS-NFT-AI-ART", "description": "AI art created by JS-NFT", "image": "https://www.dropbox.com/s/toq98op6t8g9wts/AI-POST-WORD-1.jpeg?raw=1" }')
      await nftContract.setNFTData(itemID, aiImages[itemID])
      await nftContract.tokenURI(itemID)
      itemID++;
    }
  };


const main = async () => {
    try {
      await deployContract();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  main();