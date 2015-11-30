require 'spec_helper'

include Twingly::Search

describe Parser do
  it { should respond_to(:parse) }

  describe "#parse" do
    subject { Parser.new.parse(document) }

    context "with a valid result" do
      let(:document) { Fixture.get(:valid) }

      it { is_expected.to be_a Result }
    end

    context "with a nonexistent api key result" do
      let(:document) { Fixture.get(:nonexistent_api_key) }

      it "should raise AuthError" do
        expect { subject }.to raise_error(AuthError)
      end
    end

    context "with an unauthorized api key result" do
      let(:document) { Fixture.get(:unauthorized_api_key) }

      it "should raise AuthError" do
        expect { subject }.to raise_error(AuthError)
      end
    end

    context "with a service unavailable result" do
      let(:document) { Fixture.get(:service_unavailable) }

      it "should raise ServerError" do
        expect { subject }.to raise_error(ServerError)
      end
    end

    context "with a undefined error result" do
      let(:document) { Fixture.get(:undefined_error) }

      it "should raise ServerError" do
        expect { subject }.to raise_error(ServerError)
      end
    end

    context "with a undefined error result" do
      let(:document) { Fixture.get(:non_xml) }

      it "should raise ServerError" do
        expect { subject }.to raise_error(ServerError, /503 Service Unavailable/)
      end
    end
  end
end
