require 'mongoid'
class ETH
  include Mongoid::Document
  include Mongoid::Timestamps
  # eth 地址
  field :addr, type: String
  # 余额
  field :balances, type: String
  # wallet
  field :wallet, type: String
  # 状态
  field :state, type: Integer

  belongs_to :server
end
