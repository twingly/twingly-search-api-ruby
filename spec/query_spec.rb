require 'spec_helper'
require 'uri'
require 'vcr_setup'

include Twingly::Analytics

describe Query do

  it "BASE_URL should be parsable" do
    URI(Query::BASE_URL).to_s.should == Query::BASE_URL
  end

  context "without client" do
    subject { Query.new }
    it "should not work" do
      expect { subject }.to raise_error(ArgumentError)
    end
  end

  before(:each) do
    @client = double('client')
    @client.stub(:api_key).and_return('api_key')
  end

  subject { Query.new(@client) }

  it { should respond_to(:pattern) }
  it { should respond_to(:document_language) }
  it { should respond_to(:start_time) }
  it { should respond_to(:end_time) }
  it { should respond_to(:execute) }
  it { should respond_to(:client) }
  it { subject.client.should == @client }

  describe "#url" do
    it "should add searchpattern" do
      subject.pattern = "spotify"
      subject.url.should include("searchpattern=spotify")
    end

    it "should require searchpattern" do
      expect { subject.url }.to raise_error(RuntimeError, "Missing pattern")
    end

    it "should add document_language" do
      subject.pattern = ""
      subject.document_language = "en"
      URI(subject.url).query.split('&').should include('documentlang=en')
    end

    it "should add start_time" do
      subject.pattern = ""
      subject.start_time = Time.new(2012,12,28,9,01,22)
      URI(subject.url).query.split('&').should include("ts=2012-12-28+09%3A01%3A22")
    end

    it "should add end_time" do
      subject.pattern = ""
      subject.end_time = Time.new(2013,12,28,9,01,22)
      URI(subject.url).query.split('&').should include("tsTo=2013-12-28+09%3A01%3A22")
    end
  end

  describe "#execute" do
    # it "should return a result" do
    #   subject.execute.should be_a Twingly::Analytics::Result
    # end

    # Är egentligen ett integrationstest? Borde ligga separat?
    # Bara testa så Query bygger rätt URL, och skickar en request
    # Testa så resultatet byggs upp korrekt sen

    context "when searching for spotify" do
      before { subject.pattern = "spotify" }
      it "should get posts about spotify" do
        VCR.use_cassette('search_for_spotify_on_sv_blogs', :record => :once) do
          result = subject.execute
          result.posts.should_not be_empty # Borde inte testa resultat, borde bara kolla så att den nyttjar VCR
        end
      end
    end
  end
end