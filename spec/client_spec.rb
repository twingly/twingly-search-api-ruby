require 'spec_helper'

include Twingly::Search

describe Client do
  subject { Client.new('api_key') }
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
    it { expect { subject }.to raise_error(RuntimeError, 'Missing API key') }
  end

  describe '#query' do
    subject { Client.new('api_key').query }
    it { should be_a Query }
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
          expect { subject.execute_query(query) }.to raise_error(RuntimeError, "The API key does not exist.")
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
