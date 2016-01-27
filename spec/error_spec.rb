require "spec_helper"

describe Twingly::Search::Error do
  it { is_expected.to be_a(StandardError) }

  describe ".from_api_response_message" do
    subject { described_class.from_api_response_message(server_response_message) }

    context "when given message containing 'API key'" do
      let(:server_response_message) { "... API key ..." }

      it { is_expected.to be_an(AuthError) }
    end

    context "when given a server error message" do
      let(:server_response_message) { "An error occured." }

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
