require 'sinatra'
require 'mongoid'
require 'sinatra/json'
require 'sinatra/reloader' if development?
require "sinatra/namespace"
require 'require_all'
require_all 'models'

Mongoid.load!('config/mongoid.yml')

get '/' do
  'hi boy'
end

namespace '/api/v1' do
  before do
    content_type 'application/json'
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

  get '/servers' do
    @servers = Server.all
    json server: @servers
  end

  post '/servers' do
    client_ip = @env['REMOTE_ADDR']
    @server = Server.find_or_create_by(client_ip: client_ip)
    json server: @server
  end

  put '/servers' do
    client_ip = @env['REMOTE_ADDR']
    @server = Server.find_by(client_ip: client_ip)
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

