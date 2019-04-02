require "spec_helper"

module Twingly::LiveFeed
  describe Error do
    it { is_expected.to be_a(StandardError) }

    let(:message) { "This is the error message!" }

    describe ".from_api_response" do
      subject { described_class.from_api_response(code, message) }

      context "when given code 401" do
        let(:code) { 401 }

        it { is_expected.to be_a(AuthError) }
        it { is_expected.to be_a(AuthenticationError) }
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
          it { is_expected.to be_kind_of(Twingly::LiveFeed::Error) }
        end
      end
    end
  end
end
