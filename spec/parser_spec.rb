require 'spec_helper'

include Twingly::Analytics

describe Parser do
  it { should respond_to(:parse) }

  let(:document) { File.read('spec/fixtures/valid_result.xml') }

  describe "#parse" do
    subject { Parser.new.parse(document) }
    it { should be_a Result }
  end
end