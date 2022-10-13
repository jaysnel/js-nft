const deployContract = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('JSNFT');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);

    // Call the function
    let txn = await nftContract.makeJSNFT()
    await txn.wait()
    console.log('Minted NFT #1')

    // Mint another NFT just because
    // Could easily change this to a loop for as many as I want
    txn = await nftContract.makeJSNFT()
    await txn.wait()
    console.log('Minted NFT #2')
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