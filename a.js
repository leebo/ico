var Web3 = require('web3')
web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
account = web3.eth.coinbase
to = process.argv.slice(2)
var trans_data = {
  from: account,
  to: to,
  value: web3.toWei('0.01', 'ether'),
  gasPrice: 50000000000,
  gas: 21000
}
console.log(trans_data)
// var balances = web3.eth.getBalance(web3.eth.coinbase);
// console.log(web3.fromWei(balances, 'ether'))
web3.personal.unlockAccount(account, 'lendlove');
result = web3.eth.sendTransaction(
  trans_data
)
console.log(result)
