require 'spec_helper'
require 'vcr_setup'

include Twingly::Search

describe Query do
  let(:client_double) { instance_double("Client") }

  before(:each) do
    allow(client_double).to receive(:api_key).and_return("api_key")
  end

  subject { described_class.new(client_double) }

  it { should respond_to(:pattern) }
  it { should respond_to(:language) }
  it { should respond_to(:start_time) }
  it { should respond_to(:end_time) }
  it { should respond_to(:execute) }
  it { should respond_to(:client) }

  describe ".new" do
    context "without client" do
      subject { described_class.new }

      it "should not work" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context "with block" do
      it "should yield self" do
        yielded_query = nil
        query = described_class.new(client_double) do |q|
          yielded_query = q
        end

        expect(yielded_query).to equal(query)
      end
    end
  end

  describe "#url" do
    before do
      endpoint_url = "https://api.twingly.com/analytics/Analytics.ashx"
      allow(client_double).to receive(:endpoint_url).and_return(endpoint_url)
    end

    let(:query) { described_class.new(client_double) }

    context "with valid pattern" do
      before { query.pattern = "christmas" }
      subject { query.url }

      it { should include("xmloutputversion=2") }
    end

    context "without valid pattern" do
      it "raises an error" do
        expect { query.url }.to raise_error(QueryError, "Missing pattern")
      end
    end

    context "with empty pattern" do
      before { query.pattern = "" }

      it "raises an error" do
        expect { query.url }.to raise_error(QueryError, "Missing pattern")
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
    context "when called" do
      let(:client) { instance_double("Client", "api_key") }
      subject do
        query = described_class.new(client)
        query.pattern = 'something'
        query
      end

      it "should send the query to the client" do
        expect(client).to receive(:execute_query).with(subject)

        subject.execute
      end
    end

    context "when searching for spotify" do
      subject {
        query = described_class.new(Client.new('api_key'))
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
