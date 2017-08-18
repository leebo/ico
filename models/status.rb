require 'mongoid'
class sssIco
  include Mongoid::Document
  include Mongoid::Timestamps
  # 最高区块链
  field :highblock, type: String
  # 投币地址
  field :addr, type: String
  # 投币数量
  field :eth_number, type: Integer
  # 状态 0
  field :state, type: Integer, default: 0
end
