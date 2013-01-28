# encoding: utf-8

module Twingly
  module Analytics
    class Post
      attr_reader :url, :title, :summary, :language_code, :date, :blog_url, :blog_name, :authority

      def initialize(params)
        @url = params.fetch('url')
        @title = params.fetch('title')
        @summary = params.fetch('summary')
        @language_code = params.fetch('languageCode')
        @date = params.fetch('date')
        @blog_url = params.fetch('blogUrl')
        @blog_name = params.fetch('blogName')
        @authority  = params.fetch('authority')
      end
    end
  end
end