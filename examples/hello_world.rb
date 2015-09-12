Bundler.require

# Set environment variable TWINGLY_ANALYTICS_KEY
client = Twingly::Analytics::Client.new
query = client.query
query.pattern = '"hello world"'
query.start_time = Time.now - (24 * 3600) # search last day
result = query.execute
result.posts.each do |post|
  puts post.url
end
