$redis = Redis::Namespace.new("my_app", redis: Redis.new(url: ENV['REDIS_URI']))
