# encoding: utf-8

require 'date'

module Twingly
  module Search
    # A blog post
    #
    # @attr_reader [String] url the post URL.
    # @attr_reader [String] title the post title.
    # @attr_reader [String] summary the blog post text.
    # @attr_reader [String] language_code ISO two letter language code for the
    #   language that the post was written in.
    # @attr_reader [Time] indexed the time, in UTC, when the post was indexed by Twingly.
    # @attr_reader [Time] published the time, in UTC, when the post was published.
    # @attr_reader [String] blog_url the blog URL.
    # @attr_reader [String] blog_name name of the blog.
    # @attr_reader [String] authority the blog's authority/influence.
    #   See https://developer.twingly.com/resources/ranking/#authority
    # @attr_reader [Integer] blog_rank the rank of the blog, based on authority and language.
    #   See https://developer.twingly.com/resources/ranking/#blogrank
    # @attr_reader [Array] tags
    # @attr_reader [Array] outlinks
    class Post
      attr_reader :url, :title, :summary, :language_code, :indexed,
        :published, :blog_url, :blog_name, :authority, :blog_rank, :tags,
        :outlinks

      # Sets all instance variables for the {Post}, given a Hash.
      #
      # @param [Hash] params containing blog post data.
      def set_values(params)
        @url           = params.fetch('url')
        @title         = params.fetch('title')
        @summary       = params.fetch('summary')
        @language_code = params.fetch('languageCode')
        @published     = Time.parse(params.fetch('published'))
        @indexed       = Time.parse(params.fetch('indexed'))
        @blog_url      = params.fetch('blogUrl')
        @blog_name     = params.fetch('blogName')
        @authority     = params.fetch('authority').to_i
        @blog_rank     = params.fetch('blogRank').to_i
        @tags          = params.fetch('tags', [])
        @outlinks      = params.fetch('outLinks', [])
      end
    end
  end
end
