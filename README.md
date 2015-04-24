# Twingly Analytics API Ruby

[![Build Status](https://travis-ci.org/twingly/twingly-analytics-api-ruby.png?branch=master)](https://travis-ci.org/twingly/twingly-analytics-api-ruby)
[![Code Climate](https://codeclimate.com/github/twingly/twingly-analytics-api-ruby.png)](https://codeclimate.com/github/twingly/twingly-analytics-api-ruby)

A Ruby gem for Twingly's Analytics API. Twingly is a blog search service that provides a searchable API called [Twingly Analytics](https://developer.twingly.com/resources/analytics/).

## Installation

Add to your application's [Gemfile](http://bundler.io/gemfile.html) and then run `bundle`

```Ruby
gem 'twingly-analytics', github: 'twingly/twingly-analytics-api-ruby'
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

The `twinlgy-analytics` gem talks to a commercial blog search API and requires an API key. Best practice is to set the `TWINGLY_ANALYTICS_KEY` environment variable to the obtained key. `Twingly::Analytics::Client` can be passed a key at initialization if your setup does not allow environment variables.

Too learn more about the capabilities of this API you should read the [Twingly Analytics API documentation](https://developer.twingly.com/resources/analytics/).

## Requirements

* API key, contact sales@twingly.com to get one
* Ruby 1.9, 2.0, 2.1, 2.2

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
