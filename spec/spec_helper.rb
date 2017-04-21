require File.dirname(__FILE__) + '/../lib/twingly/search'
require File.dirname(__FILE__) + '/../lib/twingly/livefeed'

require 'vcr_setup'
require 'rspec/its'

ENV["TWINGLY_SEARCH_KEY"] ||= "api_key"

class Fixture
  def self.get(fixture_name)
    filename = "spec/fixtures/#{fixture_name}_result.xml"
    File.read(filename)
  end

  def self.livefeed_get(fixture_name)
    get("livefeed/#{fixture_name}")
  end
end
