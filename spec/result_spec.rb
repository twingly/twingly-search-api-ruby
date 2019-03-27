require 'spec_helper'
require 'rspec/its'
require 'uri'

include Twingly::Search

describe Result do
  instance_methods = [
    :posts,
    :number_of_matches_returned,
    :number_of_matches_total,
    :seconds_elapsed,
    :all_results_returned?,
    :incomplete?,
  ]

  instance_methods.each do |method|
    it { should respond_to method }
  end

  context "before query has populated responses" do
    its(:posts) { should be_empty }
    its(:all_results_returned?) { should be_truthy }
  end

  describe "#inspect" do
    subject { described_class.new.inspect }

    instance_methods.each do |method|
      it { should match(/ #{Regexp.quote(method)}[,=]/) }
    end
  end
end
