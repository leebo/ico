require 'rubygems'
require 'bundler/setup'
require 'json'
require 'redis'
require 'rest-client'
require 'colorize'
require 'droplet_kit'
require 'mongoid'
require 'require_all'
require_all 'models'

Mongoid.load!('config/mongoid.yml', :development)

$client = DropletKit::Client.new(access_token: '204c0469816e5b47cd1c583b24f533871fbe416ca7aaed6c2f9141dbd73bf9bf')
server_ids = []
2.times.each do
  server = Server.create(state: 0)
  server_ids << server.id.to_s
end
# server = Server.create(state: 1)
# 建立服务器
droplet = DropletKit::Droplet.new(names: server_ids, region: 'sfo2', image: '25710398', size: '8gb')
created = $client.droplets.create_multiple(droplet)
puts created
