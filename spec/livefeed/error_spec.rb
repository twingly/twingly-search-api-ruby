require "spec_helper"

describe Twingly::LiveFeed::Error do
  it { is_expected.to be_a(StandardError) }

  let(:message) { "This is the error message!" }

  describe ".from_api_response" do
    subject { described_class.from_api_response(code, message) }

    context "when given code 401" do
      let(:code) { 401 }

      it { is_expected.to be_a(LiveFeed::AuthError) }
    end

    context "when given code 400" do
      let(:code) { 400 }

      it { is_expected.to be_a(LiveFeed::QueryError) }
    end

    context "when given code 404" do
      let(:code) { 404 }

      it { is_expected.to be_a(LiveFeed::QueryError) }
    end

    context "when given another code" do
      let(:code) { 500 }

      it { is_expected.to be_a(LiveFeed::ServerError) }
    end
  end

  describe "all error classes" do
    error_classes = [
      LiveFeed::AuthError,
      LiveFeed::ServerError,
      LiveFeed::QueryError,
    ]

    error_classes.each do |error_class|
      describe error_class do
        it { is_expected.to be_kind_of(Twingly::LiveFeed::Error) }
      end
    end
  end
end
