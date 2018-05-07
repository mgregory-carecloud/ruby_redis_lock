RSpec.configure do |config|

  config.mock_with :rspec

  config.before(:each) do
    @redis = Redis.new
    @redis.flushall
  end

end