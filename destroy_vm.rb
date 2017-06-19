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



servers = Server.all

$client = DropletKit::Client.new(access_token: '204c0469816e5b47cd1c583b24f533871fbe416ca7aaed6c2f9141dbd73bf9bf')
servers.each do |server|
$client
end
# 建立服务器
droplet = DropletKit::Droplet.new(name: server.id.to_s, region: 'sfo2', image: 'ubuntu-14-04-x64', size: '512mb')
# created = $client.droplets.create(droplet)
