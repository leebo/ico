class CreateAccountWorker
  include Sidekiq::Worker
  def perform()
    result = $client.personal_new_account('bobo')
    Account.find_or_create_by(addr: result["result"])
  end
end
