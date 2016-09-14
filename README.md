# Twingly Search API Ruby

[![Build Status](https://travis-ci.org/twingly/twingly-search-api-ruby.png?branch=master)](https://travis-ci.org/twingly/twingly-search-api-ruby)
[![Code Climate](https://codeclimate.com/github/twingly/twingly-search-api-ruby/badges/gpa.svg)](https://codeclimate.com/github/twingly/twingly-search-api-ruby)

A Ruby gem for Twingly's Search API (previously known as Analytics API). Twingly is a blog search service that provides a searchable API known as [Twingly Search API](https://developer.twingly.com/resources/search/).

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

```ruby
require "twingly/search"

client = Twingly::Search::Client.new do |client|
  client.user_agent = "MyCompany/1.0"
end

query = client.query do |query|
  query.pattern  = "github page-size:10"
  query.language = "sv"
end

result = query.execute
=> #<Twingly::Search::Result:0x3ff7adcbe3d4 @posts, @number_of_matches_returned=10, @number_of_matches_total=3035221>
result.posts # will include all returned posts
```

The `twingly-search` gem talks to a commercial blog search API and requires an API key. Best practice is to set the `TWINGLY_SEARCH_KEY` environment variable to the obtained key. `Twingly::Search::Client` can be passed a key at initialization if your setup does not allow environment variables.

To learn more about the features of this gem, read the [gem documentation] or check out the example code that can be found in [examples/](examples/).

To learn more about the capabilities of the API, please read the [Twingly Search API documentation].

[gem documentation]: http://www.rubydoc.info/github/twingly/twingly-search-api-ruby
[Twingly Search API documentation]: https://developer.twingly.com/resources/search/

## Requirements

* API key, [sign up](https://www.twingly.com/try-for-free) via [twingly.com](https://www.twingly.com/) to get one
* Ruby
  * Ruby 1.9, 2.0, 2.1, 2.2, 2.3
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
1. Generate a changelog with `bundle exec rake changelog`. Set `CHANGELOG_GITHUB_TOKEN` to a personal access token to increase the API rate limit. (The changelog uses [GitHub Changelog Generator](https://github.com/skywinder/github-changelog-generator/))
1. Update release information on the [releases page]. This is done manually.

[releases page]: https://github.com/twingly/twingly-search-api-ruby/releases
[RubyGems.org]: https://rubygems.org/

### Documentation

This gem is documented using [YARD]. To start a local YARD server run:

    bundle exec rake yard:server

The YARD server reloads the documentation automatically so there is no need to restart it when making changes.

[YARD]: http://yardoc.org/
