require 'spec_helper'
require 'rspec/its'
require 'uri'

include Twingly::Analytics

describe Result do
  it { should respond_to :posts }
  it { should respond_to :number_of_matches_returned }
  it { should respond_to :number_of_matches_total }
  it { should respond_to :seconds_elapsed }

  context "before query has populated responses" do
    its(:posts) { should be_empty }
  end
end
