require 'set'
require 'bundler'
Bundler.require

# Set environment variable TWINGLY_ANALYTICS_KEY
client = Twingly::Analytics::Client.new

finished   = nil
start_time = Time.new(2013, 01, 01)
blogs      = Set.new

until finished
  query = client.query
  query.pattern    = "sort-order:asc sort:published twingly"
  query.start_time = start_time
  query.language   = 'sv'
  result = query.execute

  result.posts.each do |post|
    blogs.add(post.blog_url)
  end

  finished = start_time == result.posts.last.published
  start_time = result.posts.last.published
end

blogs.each do |url|
  puts url
end
