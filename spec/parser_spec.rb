require 'spec_helper'

include Twingly::Analytics

describe Parser do
  it { should respond_to(:parse) }

  describe "#parse" do
    subject { Parser.new }

    context "with valid result" do
      let(:document) { File.read('spec/fixtures/valid_result.xml') }

      it "should parse document" do
        subject.parse(document).should be_a Result
      end

      # TODO testa någon annanstans
      it "should return posts" do
        subject.parse(document).posts.should be_a Array
      end
    end
  end
end