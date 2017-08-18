require 'mongoid'
class Ico
  include Mongoid::Document
  include Mongoid::Timestamps
  # 最高区块链
  field :highblock, type: String
  # 投币地址
  field :addr, type: String
  # 帐号投币数量
  field :value, type: Integer
  # 状态 0 未开始 1 开始
  field :state, type: Integer, default: 0
  has_many :ico_logs
end
