require 'spec_helper'

include Twingly::Search

describe Query do
  let(:client_double) { instance_double("Client") }

  before(:each) do
    allow(client_double).to receive(:api_key).and_return("api_key")
  end

  subject(:query) { described_class.new(client_double) }

  it { should respond_to(:search_query) }
  it { should respond_to(:language) }
  it { should respond_to(:start_time) }
  it { should respond_to(:end_time) }
  it { should respond_to(:execute) }
  it { should respond_to(:client) }

  describe "#pattern" do
    it { expect { subject.pattern }.to output(/deprecated/).to_stderr }
    it { expect { subject.pattern = "test" }.to output(/deprecated/).to_stderr }
  end

  describe "#language" do
    it { expect { subject.language }.to output(/deprecated/).to_stderr }
    it { expect { subject.language = "en" }.to output(/deprecated/).to_stderr }

    it "should be included in the search query" do
      subject.language = "no"
      expect(subject.request_parameters.fetch(:q)).to include("lang:no")
    end
  end

  describe ".new" do
    context "without client" do
      subject { described_class.new }

      it "raises an error" do
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
      endpoint_url = "https://api.twingly.com/blog/search/api/v3/search"
      allow(client_double).to receive(:endpoint_url).and_return(endpoint_url)
    end

    let(:query) { described_class.new(client_double) }

    context "without valid search query" do
      it "raises an error" do
        expect { query.url }.to raise_error(QueryError, /query cannot be empty/)
      end
    end

    context "with empty search query" do
      before { query.search_query = "" }

      it "raises an error" do
        expect { query.url }.to raise_error(QueryError, /query cannot be empty/)
      end
    end
  end

  describe "#start_time=" do
    before do
      query.search_query = "semla"
    end

    context "when given time in UTC" do
      before do
        query.start_time = time
      end

      let(:timestamp) { "2016-02-09 09:01:22 UTC" }
      let(:time) { Time.parse(timestamp) }

      it "should not change timezone" do
        expect(subject.request_parameters.fetch(:q)).to include("2016-02-09T09:01:22")
      end

      it "should not modify the given time object" do
        expect(subject.start_time.to_s).to eq(timestamp)
      end
    end

    context "when given time not in UTC" do
      before do
        @TZ = ENV["TZ"]
        # set timezone matching the timestamp, needed for Ruby versions before 2.2
        # see https://github.com/twingly/twingly-search-api-ruby/pull/52
        ENV["TZ"] = "Etc/GMT-5"

        subject.start_time = time
      end

      after do
        ENV["TZ"] = @TZ
      end

      let(:timestamp) { "2016-02-09 09:01:22 +0500" }
      let(:time) { Time.parse(timestamp) }

      it "should convert to UTC" do
        expect(subject.request_parameters.fetch(:q)).to include("2016-02-09T04:01:22")
      end

      it "should not modify the given time object" do
        expect(subject.start_time.to_s).to eq(timestamp)
      end
    end

    context "when given non-time object (except nil)" do
      let(:time) { "2013-12-28+09%3A01%3A22" }

      it "should raise exception" do
        expect { subject.start_time = time }.to raise_error(QueryError, "Not a Time object")
      end
    end

    context "when given nil" do
      before do
        subject.start_time = nil
      end

      it "should assign" do
        expect(subject.start_time).to eq(nil)
      end
    end
  end

  describe "#end_time=" do
    before do
      subject.search_query  = "semla"
    end

    context "when given time in UTC" do
      before do
        subject.end_time = time
      end

      let(:timestamp) { "2016-02-09 09:01:22 UTC" }
      let(:time) { Time.parse(timestamp) }

      it "should not change timezone" do
        expect(subject.request_parameters.fetch(:q)).to include("end-date:2016-02-09T09:01:22")
      end

      it "should not modify the given time object" do
        expect(subject.end_time.to_s).to eq(timestamp)
      end
    end

    context "when given time not in UTC" do
      before do
        @TZ = ENV["TZ"]
        # set timezone matching the timestamp, needed for Ruby versions before 2.2
        # see https://github.com/twingly/twingly-search-api-ruby/pull/52
        ENV["TZ"] = "Etc/GMT-5"

        subject.end_time = time
      end

      after do
        ENV["TZ"] = @TZ
      end

      let(:timestamp) { "2016-02-09 09:01:22 +0500" }
      let(:time) { Time.parse(timestamp) }

      it "should convert to UTC" do
        expect(subject.request_parameters.fetch(:q)).to include("end-date:2016-02-09T04:01:22")
      end

      it "should not modify the given time object" do
        expect(subject.end_time.to_s).to eq(timestamp)
      end
    end

    context "when given non-time object (except nil)" do
      let(:time) { "2013-12-28+09%3A01%3A22" }

      it "should raise exception" do
        expect { subject.end_time = time }.to raise_error(QueryError, "Not a Time object")
      end
    end

    context "when given nil" do
      before do
        subject.start_time = nil
      end

      it "should assign" do
        expect(subject.start_time).to eq(nil)
      end
    end
  end

  context "with valid search query" do
    before { subject.search_query = "christmas" }

    it "should add language" do
      subject.language = "en"
      expect(subject.request_parameters.fetch(:q)).to include("lang:en")
    end

    it "should encode url parameters" do
      subject.end_time = Time.parse("2013-12-28 09:01:22 UTC")
      expect(subject.url_parameters).to include('end-date%3A2013-12-28T09%3A01%3A22')
    end
  end

  describe "#search_query" do
    before { subject.search_query = "spotify" }

    it "should add q parameter" do
      expect(subject.url_parameters).to include("q=spotify")
    end
  end

  describe "#execute" do
    context "when called" do
      subject do
        query = described_class.new(client_double)
        query.search_query = 'something'
        query
      end

      it "should send the query to the client" do
        expect(client_double).to receive(:execute_query).with(subject)

        subject.execute
      end
    end

    context "when searching for spotify" do
      subject {
        query = described_class.new(Client.new)
        query.search_query = 'spotify page-size:10'
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
