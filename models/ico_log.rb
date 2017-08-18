require 'mongoid'
class IcoLog
  include Mongoid::Document
  include Mongoid::Timestamps
  # 投币帐号 地址
  field :account, type: String
  # 投币数量
  field :value, type: Integer
  # 是否成功
  field :is_success, type: Boolean
  # 结果
  field :result, type: String
  belongs_to :ico
end
