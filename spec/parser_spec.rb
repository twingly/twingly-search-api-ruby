require 'spec_helper'

include Twingly::Search

describe Parser do
  it { should respond_to(:parse) }

  describe "#parse" do
    subject { described_class.new.parse(document) }
    let(:document) { Fixture.get(fixture) }

    context "with a valid result" do
      let(:fixture) { :valid }

      it { is_expected.to be_a Result }
    end

    context "with a valid result containing non-blogs" do
      let(:fixture) { :valid_non_blog }

      it "should exclude the non-blog entries" do
        expect(subject.posts.size).to eq(1)
      end
    end

    context "with a nonexistent api key result" do
      let(:fixture) { :nonexistent_api_key }

      it "should raise AuthError" do
        expect { subject }.to raise_error(AuthError)
      end
    end

    context "with an unauthorized api key result" do
      let(:fixture) { :unauthorized_api_key }

      it "should raise AuthError" do
        expect { subject }.to raise_error(AuthError)
      end
    end

    context "with a service unavailable result" do
      let(:fixture) { :service_unavailable }

      it "should raise ServerError" do
        expect { subject }.to raise_error(ServerError)
      end
    end

    context "with a undefined error result" do
      let(:fixture) { :undefined_error }

      it "should raise ServerError" do
        expect { subject }.to raise_error(ServerError)
      end
    end

    context "with a undefined error result" do
      let(:fixture) { :non_xml }

      it "should raise ServerError" do
        expect { subject }.to raise_error(ServerError, /503 Service Unavailable/)
      end
    end
  end
end
