require 'sinatra'
require 'mongoid'
require 'sinatra/json'
require 'sinatra/reloader'
require 'require_all'
require_all 'models'

Mongoid.load!('config/mongoid.yml', :development)

# 获取地址发送
get '/status' do
  json status: Status.first.to_json
end

put '/status' do
  params = JSON.parse(request.body.read)
  @status = Status.first_or_create
  @status.update(addr: params["addr"], state: params["state"])
  json status: @status
end

post '/servers' do
  client_ip = @env['REMOTE_ADDR']
  @server = Server.find_or_create_by(client_ip: client_ip)
  json server: @server
end

put '/servers' do
  client_ip = @env['REMOTE_ADDR']
  @server = Server.find_by(client_ip: client_ip)
  params = JSON.parse(request.body.read)
  puts params
  params = params["server"].delete_if {|key, value| key == nil }
  @server.update(params)
  json server: @server
end


