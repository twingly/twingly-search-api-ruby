require "spec_helper"
require "time"

module Twingly::LiveFeed
  describe Client do
    let(:valid_api_key) { "api_key" }
    let(:max_posts)     { 3 }

    subject(:client) do
      described_class.new do |client|
        client.max_posts = max_posts
      end
    end

    describe ".new" do
      context "with API key as argument" do
        subject { described_class.new(valid_api_key) }

        it { should be_a Twingly::LiveFeed::Client }
      end

      context "without API key as argument" do
        before do
          expect_any_instance_of(described_class)
            .to receive(:env_api_key).and_return(valid_api_key)
        end

        it "should be read from the environment" do
          described_class.new
        end
      end

      context "with no API key at all" do
        before do
          expect_any_instance_of(described_class)
            .to receive(:env_api_key).and_return(nil)
        end

        subject { described_class.new }

        it do
          expect { subject }
            .to raise_error(AuthError, "No API key has been provided.")
        end
      end

      context "with block" do
        it "should yield self" do
          yielded_client = nil
          client = described_class.new(valid_api_key) do |c|
            yielded_client = c
          end

          expect(yielded_client).to equal(client)
        end

        context "when api key gets set in block" do
          let(:api_key) { "api_key_from_block" }
          subject do
            described_class.new do |client|
              client.api_key = api_key
            end
          end

          it "should not raise an AuthError" do
            expect { subject }.not_to raise_exception
          end

          it "should use that api key" do
            expect(subject.api_key).to eq(api_key)
          end
        end
      end

      context "with optional :user_agent given" do
        let(:user_agent) { "TwinglyLiveFeedTest/1.0" }
        subject { described_class.new(valid_api_key, user_agent: user_agent) }

        it "should use that user agent" do
          expect(subject.user_agent).to eq(user_agent)
        end
      end
    end

    describe "#next_result" do
      before do
        client.timestamp = timestamp
      end

      context "with a valid timestamp" do
        let(:timestamp) { Time.parse("2017-04-19T22:00:00 UTC") }

        subject do
          VCR.use_cassette("livefeed_valid_request") do
            client.next_result
          end
        end

        it { is_expected.to be_a(Result) }

        it "should update the timestamp" do
          timestamp_before = client.timestamp
          subject
          timestamp_after = client.timestamp

          p subject

          expect(timestamp_after).to be > timestamp_before
        end
      end

      context "with an invalid timestamp" do
        let(:timestamp) { "not a timestamp" }

        subject { client.next_result }

        it "should raise an error" do
          expect{ subject }
            .to raise_error(QueryError, /Not a Time object/)
        end
      end
    end

    describe "#get_result" do
      context "with a valid timestamp" do
        let(:timestamp) { Time.parse("2017-04-19T22:00:00 UTC") }

        subject do
          VCR.use_cassette("livefeed_valid_request") do
            client.get_result(timestamp: timestamp)
          end
        end

        it { is_expected.to be_a(Result) }

        it "should set the timestamp to the given one" do
          subject

          expect(client.timestamp).to eq(timestamp)
        end
      end

      context "with an invalid timestamp" do
        let(:timestamp) { "not a timestamp" }

        subject { client.get_result(timestamp: timestamp) }

        it "should raise an error" do
          expect{ subject }
            .to raise_error(QueryError, /Not a Time object/)
        end
      end
    end

    describe "#endpoint_url" do
      subject { described_class.new(valid_api_key).endpoint_url }
      let(:expected_url) do
        "#{described_class::BASE_URL}#{described_class::LIVEFEED_PATH}"
      end

      it { is_expected.to eq(expected_url) }

      it "should be parsable" do
        expect(URI(subject).to_s).to eq(expected_url)
      end
    end
  end
end
