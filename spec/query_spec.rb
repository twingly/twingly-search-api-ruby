require 'spec_helper'
require 'vcr_setup'

include Twingly::Search

describe Query do

  it "BASE_URL should be parsable" do
    expect(URI(Query::BASE_URL).to_s).to eq(Query::BASE_URL)
  end

  context "without client" do
    subject { Query.new }

    it "should not work" do
      expect { subject }.to raise_error(ArgumentError)
    end
  end

  before(:each) do
    @client = double('client')
    allow(@client).to receive(:api_key).and_return('api_key')
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
      before { query.pattern = "christmas" }
      subject { query.url }

      it { should include("xmloutputversion=2") }
    end

    context "without valid pattern" do
      it "raises an error" do
        expect { query.url }.to raise_error(RuntimeError, "Missing pattern")
      end
    end

    context "with empty pattern" do
      before { query.pattern = "" }

      it "raises an error" do
        expect { query.url }.to raise_error(RuntimeError, "Missing pattern")
      end
    end
  end

  context "with valid pattern" do
    before { subject.pattern = "christmas" }

    it "should add language" do
      subject.language = "en"
      expect(subject.request_parameters).to include(documentlang: 'en')
    end

    it "should add start_time" do
      subject.start_time = Time.new(2012, 12, 28, 9, 01, 22)
      expect(subject.request_parameters).to include(ts: '2012-12-28 09:01:22')
    end

    it "should add end_time" do
      subject.end_time = Time.new(2013, 12, 28, 9, 01, 22)
      expect(subject.request_parameters).to include(tsTo: '2013-12-28 09:01:22')
    end

    it "should encode url paramters" do
      subject.end_time = Time.new(2013, 12, 28, 9, 01, 22)
      expect(subject.url_parameters).to include('tsTo=2013-12-28+09%3A01%3A22')
    end
  end

  describe "#pattern" do
    before { subject.pattern = "spotify" }

    it "should add searchpattern" do
      expect(subject.url_parameters).to include("searchpattern=spotify")
    end
  end

  describe "#execute" do
    context "with invalid API key" do
      subject {
        query = Query.new(Client.new('wrong'))
        query.pattern = 'something'
        query
      }

      it "should raise error on invalid API key" do
        VCR.use_cassette('search_without_valid_api_key') do
          expect { subject.execute }.to raise_error(RuntimeError, "The API key does not exist.")
        end
      end
    end

    context "when searching for spotify" do
      subject {
        query = Query.new(Client.new('api_key'))
        query.pattern = 'spotify page-size:10'
        query.language = 'sv'
        query
      }

      it "should get posts when searching for spotify" do
        VCR.use_cassette('search_for_spotify_on_sv_blogs') do
          result = subject.execute
          expect(result.posts).not_to be_empty
        end
      end
    end
  end
end
