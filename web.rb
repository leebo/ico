require 'sinatra'
require 'mongoid'
require 'sinatra/json'
require 'sinatra/reloader' if development?
require "sinatra/namespace"
require 'jeth'
require './utils.rb'
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

  # 创建帐号
  get '/create_account' do
    CreateAccountWorker.perform_async()
    result = {result: "ok"}
    json result
  end
  # 更新帐号及账户余额
  get '/update_account' do
    UpdateAccountWorker.perform_async()
    result = {result: "ok"}
    json result
  end
  # 备份所有地址
  get '/backup' do
    `cd /root/.ethereum/keystore && tar -czvf /root/ico/public/backup.tar.gz *`
    send_file File.join(settings.public_folder, 'backup.tar.gz')
  end

  # 获取地址发送
  get '/icos' do
    json Status.All
  end
  # 获取地址发送
  get '/icos/go' do
    json Status.find_by(state: 1)
  end

  put '/icos/:id' do
    params = JSON.parse(request.body.read)
    params = params.delete_if {|key, value| key == nil }
    @status = Status.find(id)
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

