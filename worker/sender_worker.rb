class SenderWorker
  include Sidekiq::Worker
  def perform(ico_id, from, to, value)
    ico = Ico.find(ico_id)
    # unlock 钱包
    puts $client.personal_unlock_account(from, 'bobo')
    trans_data = {
      from: from,
      to: to,
      value: "0x" + Ethereum::Formatter.to_wei(value).to_s(16),
      gasPrice: "0x" + 500000000000.to_s(16),
      gas: "0x" + 21000.to_s(16)
    }
    result = $client.eth_send_transaction(
      trans_data
    )
    puts result
    ico.ico_logs.create(account: from, value: value, result: result["result"])
  end
end
