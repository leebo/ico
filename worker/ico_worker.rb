class IcoWorker
  include Sidekiq::Worker

  def perform()
    while true
      if ico = Ico.find_by(state: 1)
        while true
          # 查询当前区块链高度 如果等于目标高度 则开始投ico
          # current_block = $client.eth_block_number["result"]
          # puts "当前区块高度${current_block}"
          # puts "ico区块高度${ico.highblock}"
          time = Time.now.utc
          puts "#{time.sec} #{time.min}"
          # if time.sec == 0 && time.min == 8 && (time.hour + 8) == 20
            # if current_block == ico.highblock
            Account.all.each do |account|
              if account.balance > 0
                SenderWorker.perform_async(ico.id.to_s, account.addr, ico.addr, account.balance - 10)
              end
            end
            ico.update(state: 0)
            break
          # end
          # end
        end
      end
      puts "没有ico 延迟"
      sleep 5
    end
  end

end
