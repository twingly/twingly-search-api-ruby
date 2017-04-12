require File.dirname(__FILE__) + '/../lib/twingly/search'
require File.dirname(__FILE__) + '/../lib/twingly/livefeed'

class Fixture
  def self.get(fixture_name)
    filename = "spec/fixtures/#{fixture_name}_result.xml"
    File.read(filename)
  end

  def self.livefeed_get(fixture_name)
    get("livefeed/#{fixture_name}")
  end
end
