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
gem 'twingly-search'
```

## Usage

```ruby
require 'twingly/search'

client = Twingly::Search::Client.new do |client|
  client.user_agent = "MyCompany/1.0"
end

query = client.query do |query|
  query.pattern  = 'github page-size:10'
  query.language = 'sv'
end

result = query.execute
=> #<Twingly::Search::Result:0x3ff7adcbe3d4 @posts, @number_of_matches_returned=10, @number_of_matches_total=3035221>
result.posts # will include all returned posts
```

The `twingly-search` gem talks to a commercial blog search API and requires an API key. Best practice is to set the `TWINGLY_SEARCH_KEY` environment variable to the obtained key. `Twingly::Search::Client` can be passed a key at initialization if your setup does not allow environment variables.

Example code can be found in [examples/](examples/).

Too learn more about the capabilities of this API you should read the [Twingly Search API documentation](https://developer.twingly.com/resources/search/).

## Requirements

* API key, contact sales@twingly.com to get one
* Ruby
  * Ruby 1.9, 2.0, 2.1, 2.2
  * JRuby 9000

## Development and release

1. Make sure the master branch has an up-to-date changelog. Generate with `rake changelog`. Set `CHANGELOG_GITHUB_TOKEN` to a personal access token to increase the API rate limit. (The changelog uses [GitHub Changelog Generator](https://github.com/skywinder/github-changelog-generator/))
1. Bump version in `lib/twingly/search/version.rb`, follow [Semantic Versioning 2.0.0](http://semver.org/)
1. Build and release gem with `bundle exec rake release`. This will create a git tag for the version and push the `.gem` file to https://rubygems.org/.
1. Update release information on the [releases page].

[releases page]: https://github.com/twingly/twingly-search-api-ruby/releases

### Documentation

This gem is documented using [YARD]. To start a local YARD server run:

    bundle exec rake yard:server

The YARD server reloads the documentation automatically so there is no need to restart it when making changes.

[YARD]: http://yardoc.org/

## License

The MIT License (MIT)

Copyright (c) 2013 Twingly AB

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
