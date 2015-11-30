require 'spec_helper'

include Twingly::Search

describe Client do
  subject { Client.new('api_key') }

  describe ".new" do
    context 'with API key as arguments' do
      it { should be_a Client }
    end

    it "BASE_URL should be parsable" do
      expect(URI(Client::BASE_URL).to_s).to eq(Client::BASE_URL)
    end

    context 'with API key from ENV variable' do
      before { allow_any_instance_of(Client).to receive(:env_api_key).and_return('api_key') }
      subject { Client.new }
      it { should be_a Client }
    end

    context 'without valid API key' do
      before { allow_any_instance_of(Client).to receive(:env_api_key).and_return(nil) }
      subject { Client.new }
      it { expect { subject }.to raise_error(AuthError, "No API key has been provided.") }
    end

    context "with optional :user_agent given" do
      let(:user_agent) { "TwinglySearchTest/1.0" }
      subject { Client.new('api_key', user_agent: user_agent) }

      it "should use that user agent" do
        expect(subject.user_agent).to eq(user_agent)
      end
    end

    context "with block" do
      it "should yield self" do
        yielded_client = nil
        client = Client.new("api_key") do |c|
          yielded_client = c
        end

        expect(yielded_client).to equal(client)
      end

      context "when api key gets set in block" do
        before { allow_any_instance_of(Client).to receive(:env_api_key).and_return(nil) }
        let(:api_key) { "api_key_from_block" }
        subject do
          Client.new do |client|
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
  end

  describe '#query' do
    subject { Client.new('api_key').query }
    it { should be_a Query }

    context "with block" do
      subject { Client.new("api_key") }

      it "should yield the query" do
        yielded_query = nil
        query = subject.query do |q|
          yielded_query = q
        end

        expect(yielded_query).to equal(query)
      end
    end
  end

  describe "#execute_query" do
    context "with invalid API key" do
      subject { Client.new("wrong") }

      let(:query) do
        query = subject.query
        query.pattern = "something"
        query
      end

      it "should raise error on invalid API key" do
        VCR.use_cassette("search_without_valid_api_key") do
          expect { subject.execute_query(query) }.to raise_error(AuthError, "The API key does not exist.")
        end
      end
    end
  end

  describe "#endpoint_url" do
    subject { Client.new("api_key").endpoint_url }
    let(:expected) { "#{Client::BASE_URL}#{Client::SEARCH_PATH}" }

    it { is_expected.to eq(expected) }

    it "should be parsable" do
      expect(URI(subject).to_s).to eq(expected)
    end
  end
end
