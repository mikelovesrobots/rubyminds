# Make a connection to Redis 
begin
  $redis = Redis.new
rescue Errno::ECONNREFUSED 
  raise "Redis database not available"
end
