require 'rubygems'
require 'bundler/setup'
require 'json'
require 'redis'
require 'rest-client'
require 'colorize'
require 'droplet_kit'
require 'mongoid'
require 'upyun'
upyun = Upyun::Rest.new('xj8-img', "bobo", "lendlove")
# require 'require_all'
# require_all 'libs'

# 新建主机
server = JSON.parse(RestClient.post('http://138.68.241.151:4567/servers', {}).body)["server"]
puts server
# 新建钱包
puts "===============开始新建钱包================="
`echo "lendlove" >> pass`
addr = `geth --password pass account new`
addr = addr.split('{')[1].gsub!('}', '')
puts addr
# 备份钱包
puts "===============开始备份================="
key_path = Dir["/root/.ethereum/keystore/*"][0]
file = File.new(key_path, "r")
upyun.put(server["_id"]["$oid"], file.gets)
# wallet = file.gets
# file.close
# puts wallet.to_json
# 提交钱包和地址
puts RestClient.put('http://138.68.241.151:4567/servers', { server: { addr: addr } } ).body

# 查询状态 直到开始 执行转币指令

puts "查询发送状态"
while true
  status = JSON.parse(RestClient.get('http://138.68.241.151:4567/status').body["status"])
  if status["state"] == 1
    # 状态成功
    # 执行操作
    # `node a.js  #{status['addr']}`
  else
    puts '请耐心等待'
  end
  sleep 2
end

