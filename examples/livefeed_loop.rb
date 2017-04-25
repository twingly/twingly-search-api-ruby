Bundler.require

require "twingly/livefeed"

# Set environment variable TWINGLY_SEARCH_KEY
client = Twingly::LiveFeed::Client.new do |client|
  # get posts published less than an hour ago
  client.timestamp = (Time.now - 3600)
  client.max_posts = 4000
end

loop do
  result = client.next_result

  result.posts.each do |post|
    puts "#{post.indexed_at} - #{post.url}"
  end

  # You're faster than Twingly! Take a break and wait for
  # us to index some new posts before asking again
  if result.number_of_posts < result.max_number_of_posts
    sleep 20
  end
end
