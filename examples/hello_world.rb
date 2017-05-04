Bundler.require

# Set environment variable TWINGLY_SEARCH_KEY
client = Twingly::Search::Client.new
query = client.query do |query|
  query.search_query = '"hello world"'
  query.start_time   = Time.now - (24 * 3600) # search last day
end

result = query.execute
result.posts.each do |post|
  puts post.url
end
