class UpdateAccountWorker
  include Sidekiq::Worker

  def perform()
    $client.personal_list_accounts["result"].each do |a|
      account = Account.find_or_create_by(addr: a)
      wei_value = $client.eth_get_balance(a, 'latest')["result"].to_i(16)
      eth_value = Ethereum::Formatter.from_wei(wei_value)
      account.update(balance: eth_value)
    end
  end
end
