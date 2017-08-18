class SenderWorker
  include Sidekiq::Worker

  def perform()
    $client.personal_list_accounts["result"].each do |a|
      account = Account.find_or_create_by(addr: a)
      account.update(balance: $client.eth_get_balance(a, 'latest')["result"].to_i(16))
      p account
    end
  end
end
