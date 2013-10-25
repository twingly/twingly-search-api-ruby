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
  it { should respond_to(:language) }
  it { should respond_to(:start_time) }
  it { should respond_to(:end_time) }
  it { should respond_to(:execute) }
  it { should respond_to(:client) }

  describe "#url" do
    let(:query) { Query.new(@client) }

    context "with valid pattern" do
      before { Query.any_instance.stub(:pattern).and_return('') }
      subject { query.url }
      it { should include("xmloutputversion=2") }
    end

    context "without valid pattern" do
      it "raises an error" do
        expect { query.url }.to raise_error(RuntimeError, "Missing pattern")
      end
    end
  end

  context "with valid pattern" do
    before { Query.any_instance.stub(:pattern).and_return('') }
    it "should add language" do
      subject.language = "en"
      params = URI(subject.url).query.split('&')

      params.should include('documentlang=en')
    end

    it "should add start_time" do
      subject.start_time = Time.new(2012, 12, 28, 9, 01, 22)
      params = URI(subject.url).query.split('&')

      params.should include("ts=2012-12-28+09%3A01%3A22")
    end

    it "should add end_time" do
      subject.end_time = Time.new(2013, 12, 28, 9, 01, 22)
      params = URI(subject.url).query.split('&')

      params.should include("tsTo=2013-12-28+09%3A01%3A22")
    end
  end

  describe "#pattern" do
    it "should add searchpattern" do
      subject.pattern = 'spotify'
      subject.url.should include("searchpattern=spotify")
    end
  end

  # describe "#execute" do
  #   context "with invalid API key" do
  #     subject { Query.new(Client.new('wrong')) }
  #     it "should raise error on invalid API key" do
  #       VCR.use_cassette('search_without_valid_api_key', :record => :all) do
  #         expect { subject.execute }.to raise_error(RuntimeError, "The API key does not exist.")
  #       end
  #     end
  #   end

  #   context "when searching for spotify" do
  #     subject { Query.new(Client.new) }
  #     it "should get posts about spotify" do
  #       VCR.use_cassette('search_for_spotify_on_sv_blogs', :record => :all) do
  #         result = subject.execute
  #         result.posts.should_not be_empty # Borde inte testa resultat, borde bara kolla så att den nyttjar VCR
  #       end
  #     end
  #   end
  # end
end
