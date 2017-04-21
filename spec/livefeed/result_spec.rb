require 'spec_helper'
require 'rspec/its'
require 'uri'

include Twingly

describe LiveFeed::Result do
  it { should respond_to :posts }
  it { should respond_to :ts }
  it { should respond_to :from }
  it { should respond_to :number_of_posts }
  it { should respond_to :max_number_of_posts }
  it { should respond_to :first_post }
  it { should respond_to :last_post }

  context "before query has populated responses" do
    its(:posts) { should be_empty }
  end
end
