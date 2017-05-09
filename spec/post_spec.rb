require 'spec_helper'

include Twingly::Search

describe Post do
  it { should respond_to :id }
  it { should respond_to :author }
  it { should respond_to :url }
  it { should respond_to :title }
  it { should respond_to :text }
  it { should respond_to :location_code }
  it { should respond_to :language_code }
  it { should respond_to :coordinates }
  it { should respond_to :links }
  it { should respond_to :tags }
  it { should respond_to :images }
  it { should respond_to :indexed_at }
  it { should respond_to :published_at }
  it { should respond_to :reindexed_at }
  it { should respond_to :inlinks_count }
  it { should respond_to :blog_id }
  it { should respond_to :blog_name }
  it { should respond_to :blog_url }
  it { should respond_to :blog_rank }
  it { should respond_to :authority }

  deprecated_methods = %i(summary indexed published outlinks)
  deprecated_methods.each do |method_name|
    describe "##{method_name}" do
      it do
        expect { subject.public_send(method_name) }
          .to output(/deprecated/).to_stderr
      end
    end
  end
end
