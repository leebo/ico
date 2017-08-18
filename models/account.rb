require 'mongoid'
class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  # eth 地址
  field :addr, type: String
  # 余额
  field :balance, type: Float
  # wallet
  field :wallet, type: String
  # 状态
  field :state, type: Integer, default: 0

  validates :addr, uniqueness: true
end
