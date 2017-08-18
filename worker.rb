require 'sidekiq'
require 'jeth'
require 'mongoid'
require 'require_all'
require_all 'models'
require_all 'worker'
Sidekiq.configure_client do |config|
  config.redis = {db: 1}
end
Sidekiq.configure_server do |config|
  config.redis = {db: 1}
end
$client = Jeth::HttpClient.new('http://165.227.20.127:8545')
Mongoid.load!('config/mongoid.yml')
