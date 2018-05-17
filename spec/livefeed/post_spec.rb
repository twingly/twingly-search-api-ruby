require 'spec_helper'

module Twingly::LiveFeed
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
  end

  describe "#to_h" do
    let(:post) do
      document = Fixture.livefeed_get(:valid)
      result = Parser.new.parse(document)

      result.posts.first
    end

    let(:post_hash) do
      post.to_h
    end

    attributes = %i[
      id
      author
      url
      title
      text
      location_code
      language_code
      coordinates
      links
      tags
      images
      indexed_at
      published_at
      reindexed_at
      inlinks_count
      blog_id
      blog_name
      blog_url
      blog_rank
      authority
    ]

    it do
      expect(post_hash.keys).to match_array(attributes)
    end

    attributes.each do |key|
      describe "#to_h[:#{key}]" do
        subject { post_hash[key] }
        it { is_expected.to eq(post.public_send(key)) }
      end
    end
  end
end
