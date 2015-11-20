# encoding: utf-8

require 'date'

module Twingly
  module Search
    class Post
      attr_reader :url, :title, :summary, :language_code, :indexed,
        :published, :blog_url, :blog_name, :authority, :blog_rank, :tags

      def set_values(params)
        @url           = params.fetch('url')
        @title         = params.fetch('title')
        @summary       = params.fetch('summary')
        @language_code = params.fetch('languageCode')
        @published     = DateTime.parse(params.fetch('published'))
        @indexed       = DateTime.parse(params.fetch('indexed'))
        @blog_url      = params.fetch('blogUrl')
        @blog_name     = params.fetch('blogName')
        @authority     = params.fetch('authority').to_i
        @blog_rank     = params.fetch('blogRank').to_i
        @tags          = params.fetch('tags', [])
      end
    end
  end
end
