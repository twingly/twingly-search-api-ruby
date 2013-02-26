require 'spec_helper'
require 'uri'

include Twingly::Analytics

describe Result do
  it { should respond_to :posts }
  it { should respond_to :number_of_matches_returned }
  it { should respond_to :number_of_matches_total }
  it { should respond_to :seconds_elapsed }

  its(:posts) { should be_empty }
end
