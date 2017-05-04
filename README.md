# Twingly Search API Ruby

[![Build Status](https://travis-ci.org/twingly/twingly-search-api-ruby.png?branch=master)](https://travis-ci.org/twingly/twingly-search-api-ruby)
[![Code Climate](https://codeclimate.com/github/twingly/twingly-search-api-ruby/badges/gpa.svg)](https://codeclimate.com/github/twingly/twingly-search-api-ruby)

A Ruby gem for Twingly's Blog Search API (previously known as Analytics API) and Blog LiveFeed API. Twingly is a blog search service that provides a searchable API known as [Twingly Blog Search API][Blog Search API documentation] and a blog data firehose called [Twingly Blog LiveFeed API][Blog LiveFeed API documentation].

## Installation

Install via RubyGems

```shell
gem install twingly-search
```

Or add to your application's [Gemfile](http://bundler.io/gemfile.html) and then run `bundle`

```ruby
gem "twingly-search"
```

## Usage

The `twingly-search` gem talks to a commercial API and requires an API key. Best practice is to set the `TWINGLY_SEARCH_KEY` environment variable to the obtained key. `Twingly::Search::Client` and `Twingly::LiveFeed::Client` can be passed a key at initialization if your setup does not allow environment variables.

To learn more about the features of this gem, read the [gem documentation] or check out the example code that can be found in [examples/](examples/).

To learn more about the capabilities of Twingly's APIs, please read the [Blog Search API documentation] and [Blog LiveFeed API documentation].

[gem documentation]: http://www.rubydoc.info/github/twingly/twingly-search-api-ruby
[Blog Search API documentation]: https://developer.twingly.com/resources/search/
[Blog LiveFeed API documentation]: https://developer.twingly.com/resources/livefeed/

### Blog Search API

```ruby
require "twingly/search"

client = Twingly::Search::Client.new do |client|
  client.user_agent = "MyCompany/1.0"
end

query = client.query do |query|
  query.search_query  = "github page-size:10"
  query.language      = "sv"
end

result = query.execute
=> #<Twingly::Search::Result:0x3ff7adcbe3d4 @posts, @number_of_matches_returned=10, @number_of_matches_total=3035221>
result.posts # will include all returned posts
```

### Blog LiveFeed API

```ruby
require "twingly/livefeed"

client = Twingly::LiveFeed::Client.new do |client|
  client.user_agent = "MyCompany/1.0"
  # Start getting posts indexed by Twingly at this timestamp
  client.timestamp = Time.now - 3600 # 1 hour ago
  client.max_posts = 1000            # Maximum number of posts returned per call
end

# get the next chunk of posts
result = client.next_result
=> #<Twingly::LiveFeed::Result:0x3fcd98215c14 @posts, @ts=2017-04-18 14:42:18 UTC, @from=2017-04-18 13:42:06 UTC, @number_of_posts=989, @max_number_of_posts=1000, @first_post=2017-04-18 13:42:19 UTC, @last_post=2017-04-18 14:42:13 UTC>

result.posts # will include all returned posts
```

## Requirements

* API key, [sign up](https://www.twingly.com/try-for-free) via [twingly.com](https://www.twingly.com/) to get one
* Ruby
  * Ruby 2.1, 2.2, 2.3
  * JRuby 9000

## Development

### Tests

Make sure you have all the dependencies

    bundle

Run the tests

    bundle exec rake

### Release

1. Make a commit bumping the version in `lib/twingly/search/version.rb`, follow [Semantic Versioning 2.0.0](http://semver.org/). No need to push as this will be taken care of automatically in the next step.
1. Build and the release gem with `bundle exec rake release`. This will create a git tag for the version and push the `.gem` file to [RubyGems.org].
1. Generate a changelog with `github_changelog_generator` (`gem install github_changelog_generator` if you don't have it). Set `CHANGELOG_GITHUB_TOKEN` to a personal access token to increase the API rate limit. (The changelog uses [GitHub Changelog Generator](https://github.com/skywinder/github-changelog-generator/))
1. Update release information on the [releases page]. This is done manually.

[releases page]: https://github.com/twingly/twingly-search-api-ruby/releases
[RubyGems.org]: https://rubygems.org/

### Documentation

This gem is documented using [YARD]. To start a local YARD server run:

    bundle exec rake yard:server

The YARD server reloads the documentation automatically so there is no need to restart it when making changes.

[YARD]: http://yardoc.org/
