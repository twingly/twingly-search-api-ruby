require File.dirname(__FILE__) + '/../lib/twingly/search'

class Fixture
  def self.get(fixture_name)
    filename = "spec/fixtures/#{fixture_name}_result.xml"
    File.read(filename)
  end
end
