# Twingly Analytics API Ruby

A Ruby gem for Twingly's Analytics API. Twingly is a blog indexing that provides a searchable API called Twingly Analytics.

## Installation

Add to your application's [Gemfile](http://bundler.io/gemfile.html) and then run `bundle`

```Ruby
gem 'twingly-analytics'
```

## Usage


```Ruby
require 'twingly-analytics'

client = Twingly::Analytics::Client.new
query = client.query
query.pattern = 'github page-size:10'
query.language = 'sv'
result = query.execute
=> #<Twingly::Analytics::Result:0x3ff7adcbe3d4 @posts, @number_of_matches_returned=10, @number_of_matches_total=3035221>
result.posts # will include all returned posts
```

The `twinlgy-analytics` gem talks to a commercial blog search API and requires an API key. Best practice is to set the `TWINGLY_ANALYTICS_KEY` environment variable to the obtained key. `Twingly::Analytics::Client` can be passed a key at initialization if you're setup does not allow environment variables.

## Requirements

* API key, contact sales@twingly.com to get one
* Ruby 1.9 or 2.0
