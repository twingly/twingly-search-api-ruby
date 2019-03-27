require 'spec_helper'

module Twingly::LiveFeed
  describe Result do
    instance_methods = [
      :posts,
      :ts,
      :from,
      :number_of_posts,
      :max_number_of_posts,
      :first_post,
      :last_post,
      :next_timestamp,
    ]

    instance_methods.each do |method|
      it { should respond_to method }
    end

    context "before query has populated responses" do
      its(:posts) { should be_empty }
    end

    describe "#inspect" do
      subject { described_class.new.inspect }

      instance_methods.each do |method|
        it { should match(/ #{Regexp.quote(method)}[,=]/) }
      end
    end
  end
end
