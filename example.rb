require 'twingly-analytics'

client = Twingly::Analytics::Client.new(api_key)

query = client.query(params)
# or
query = Twingly::Analytics::Query.new(client, params)

# Paginate? Max limit?
result = query.execute
result.posts.each do |post|
  puts post[:url]
end

Twingly::Analytics::Query
Twingly::Analytics::Result
Twingly::Analytics::Post

# Till README

# Alternativt ENV['TWINLGY_ANALYTICS_CLIENT_API_KEY']
client = Twingly::Analytics::Client.new(api_key)
query = client.query
query.pattern = 'spotify'
query.document_lang = 'en'
result = query.execute
result.posts.each do |post|
  puts post[:url]
end

result = query(start_time: result.posts.last[:time]).execute

# Bör framgå hur det sorteras, så man vet att det sorteras på time.
# Alternativt absahera med last_record, och bara skicka in det till
# query() när man frågar igen.

result = query(start_at: result.last_post).execute

# Det hade varit väldigt smidigt om man bara kunde gå igenom allt i ett svep, fast den i bakgrunden gör nya anrop. Men då skulle man nog behöva lazy-evaluation vilket gör det lite svårare.
# Är nog bäst att skriva utan detta först.

query.limit = 1000 # By default isf

# Nytt Alternativt
client = Twingly::Analytics::Client.new(api_key)
options = {document_lang: 'en'}
client.query('spotify', options)
query.each do |post|
end
