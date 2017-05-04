require "spec_helper"

describe Twingly::Search::Error do
  it { is_expected.to be_a(StandardError) }

  let(:message) { "This is the error message!" }

  describe ".from_api_response" do
    subject { described_class.from_api_response(code, message) }

    context "when given code 401" do
      let(:code) { 401 }

      it { is_expected.to be_a(AuthError) }
    end

    context "when given code 402" do
      let(:code) { 402 }

      it { is_expected.to be_a(AuthError) }
    end

    context "when given code 400" do
      let(:code) { 400 }

      it { is_expected.to be_a(QueryError) }
    end

    context "when given code 404" do
      let(:code) { 404 }

      it { is_expected.to be_a(QueryError) }
    end

    context "when given another code" do
      let(:code) { 500 }

      it { is_expected.to be_a(ServerError) }
    end
  end

  describe "all error classes" do
    error_classes = [
      AuthError,
      ServerError,
      QueryError,
    ]

    error_classes.each do |error_class|
      describe error_class do
        it { is_expected.to be_kind_of(Twingly::Search::Error) }
      end
    end
  end
end
