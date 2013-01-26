require 'spec_helper'

include Twingly::Analytics

describe Parser do
  context "with valid result" do
    let(:document) { File.read('spec/fixtures/valid_result.xml') }
    it { should respond_to(:parse) }
    it "should parse document" do
      subject.parse(document).should be_a Result
    end
  end
end