require 'sinatra'
require 'mongoid'
require 'sinatra/json'
require 'sinatra/reloader' if development?
require "sinatra/namespace"
require 'jeth'
require 'require_all'
require './worker.rb'
require_all 'models'

Mongoid.load!('config/mongoid.yml')

get '/' do
  SenderWorker.perform_async()
  result = { a: "b"}
  json result
end

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  # 备份所有地址
  get '/backup' do
    `cd /root/.ethereum/keystore && tar -czvf /root/ico/public/backup.tar.gz *`
    send_file File.join(settings.public_folder, 'backup.tar.gz')
  end

  # 获取地址发送
  get '/status' do
    json status: Status.first
  end

  put '/status' do
    params = JSON.parse(request.body.read)
    params = params.delete_if {|key, value| key == nil }
    @status = Status.first_or_create
    @status.update(params)
    json status: @status
  end

  get '/accounts' do
    @accounts = Account.all
    json server: @accounts
  end

  post '/accounts' do
    client_ip = @env['REMOTE_ADDR']
    @server = Account.find_or_create_by(client_ip: client_ip)
    json server: @server
  end

  put '/accounts' do
    client_ip = @env['REMOTE_ADDR']
    @server = Account.find_by(client_ip: client_ip)
    if @server.wallet
      json server: nil
      return
    end
    params = JSON.parse(request.body.read)
    puts params
    params = params["server"].delete_if {|key, value| key == nil }
    @server.update(params)
    json server: @server
  end

end

