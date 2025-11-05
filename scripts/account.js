(async () => {
    const accounts = await web3.eth.getAccounts();
    const balance = await web3.eth.getBalance(accounts[0]);
    console.log(balance)
    console.log(accounts, accounts.length);
})()
