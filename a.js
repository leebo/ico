var Web3 = require('web3')
var server = '165.227.20.127'
var web3 = new Web3(new Web3.providers.HttpProvider('http://' + server + ':8545'));
var from = process.argv.slice(2)
var to = process.argv.slice(3)
var value = process.argv.slice(4)
var trans_data = {
  from: from,
  to: to,
  value: 100,
  gasPrice: 50000000000,
  gas: 21000
}
// var balances = web3.eth.getBalance(web3.eth.coinbase);
// console.log(web3.fromWei(balances, 'ether'))
console.log(web3.personal)
web3.personal_unlockAccount(from, 'bobo');
result = web3.eth.sendTransaction(
  trans_data
)
console.log(result)
