require 'mongoid'
class Server
  include Mongoid::Document
  include Mongoid::Timestamps
  # 服务器ip
  field :client_ip, type: String
  # eth 地址
  field :addr, type: String
  # 余额
  field :balance, type: String
  # wallet
  field :wallet, type: String
  # wallet
  field :hostname, type: String
end
