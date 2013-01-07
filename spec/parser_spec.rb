require 'spec_helper'

include Twingly::Analytics

describe Parser do
  context "with valid result" do
    let(:document) { File.read('fixtures/valid_result.xml') }
    subject { Parser.new() }
  end
end