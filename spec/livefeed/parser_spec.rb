# encoding: utf-8

require 'spec_helper'
require 'time'

module Twingly::LiveFeed
  describe Parser do
    it { should respond_to(:parse) }

    describe "#parse" do
      let(:document)   { Fixture.livefeed_get(fixture) }
      subject(:result) { described_class.new.parse(document) }

      context "with a valid result" do
        let(:fixture) { :valid }

        it { is_expected.to be_a Result }

        describe "#ts" do
          subject { result.ts }
          it { is_expected.to eq(Time.parse("2017-04-11T15:09:48.8750635Z")) }
        end

        describe "#from" do
          subject { result.from }
          it { is_expected.to eq(Time.parse("2017-04-10T22:00:00Z")) }
        end

        describe "#first_post" do
          subject { result.first_post }
          it { is_expected.to eq(Time.parse("2017-04-10T22:00:29.267Z")) }
        end

        describe "#last_post" do
          subject { result.last_post }
          it { is_expected.to eq(Time.parse("2017-04-10T22:11:47.243Z")) }
        end

        describe "#number_of_posts" do
          subject { result.number_of_posts }
          it { is_expected.to eq(3) }
        end

        describe "#max_number_of_posts" do
          subject { result.max_number_of_posts }
          it { is_expected.to eq(3) }
        end

        describe "#posts" do
          subject { result.posts }

          it { is_expected.to all(be_a(Post)) }

          describe "#count" do
            subject { result.posts.count }

            it { is_expected.to eq(3) }
          end
        end

        describe "#posts.first" do
          subject(:post) { result.posts.first }

          describe "#id" do
            subject { post.id }
            it { is_expected.to eq("727444183574244541") }
          end

          describe "#author" do
            subject { post.author }
            it { is_expected.to eq("") }
          end

          describe "#url" do
            subject { post.url }
            it { is_expected.to eq("http://flinnman.blogg.se/2017/april/mandag-igen.html") }
          end

          describe "#title" do
            subject { post.title }
            it { is_expected.to eq("Måndag igen") }
          end

          describe "#text" do
            subject { post.text }
            it { is_expected.to match("Hoppla hejsan bloggy!Måndag.") }
          end

          describe "#language_code" do
            subject { post.language_code }
            it { is_expected.to eq("sv") }
          end

          describe "#location_code" do
            subject { post.location_code }
            it { is_expected.to eq("se") }
          end

          describe "#coordinates" do
            subject { post.coordinates }
            it { is_expected.to eq({}) }
          end

          describe "#links" do
            subject { post.links }
            it { is_expected.to be_empty }
          end

          describe "#tags" do
            subject { post.tags }
            it { is_expected.to eq(%w(Jag)) }
          end

          describe "#images" do
            subject { post.images }
            it { is_expected.to be_empty }
          end

          describe "#indexed_at" do
            subject { post.indexed_at }
            it { is_expected.to eq(Time.parse("2017-04-10T22:00:24Z")) }
          end

          describe "#published_at" do
            subject { post.published_at }
            it { is_expected.to eq(Time.parse("2017-04-10T19:11:11Z")) }
          end

          describe "#reindexed_at" do
            subject { post.reindexed_at }
            it { is_expected.to eq(Time.parse("2017-04-10T22:00:24Z")) }
          end

          describe "#inlinks_count" do
            subject { post.inlinks_count }
            it { is_expected.to eq(0) }
          end

          describe "#blog_id" do
            subject { post.blog_id }
            it { is_expected.to eq("10357806725947705095") }
          end

          describe "#blog_name" do
            subject { post.blog_name }
            it { is_expected.to eq("Frida L") }
          end

          describe "#blog_url" do
            subject { post.blog_url }
            it { is_expected.to eq("http://flinnman.blogg.se") }
          end

          describe "#blog_rank" do
            subject { post.blog_rank }
            it { is_expected.to eq(1) }
          end

          describe "#authority" do
            subject { post.authority }
            it { is_expected.to eq(2) }
          end
        end

        describe "#posts.last" do
          subject(:post) { result.posts.last }

          describe "#id" do
            subject { post.id }
            it { is_expected.to eq("3062976931264108164") }
          end

          describe "#author" do
            subject { post.author }
            it { is_expected.to eq("josegacel") }
          end

          describe "#url" do
            subject { post.url }
            it { is_expected.to eq("https://josegabrielcelis.wordpress.com/2017/04/09/1476/") }
          end

          describe "#title" do
            subject { post.title }
            it { is_expected.to eq("") }
          end

          describe "#text" do
            subject { post.text }
            it { is_expected.to eq("from Instagram: http://ift.tt/2ofZdhV") }
          end

          describe "#language_code" do
            subject { post.language_code }
            it { is_expected.to eq("sv") }
          end

          describe "#location_code" do
            subject { post.location_code }
            it { is_expected.to eq("") }
          end

          describe "#coordinates" do
            subject { post.coordinates }
            it { is_expected.to eq({}) }
          end

          describe "#links" do
            subject { post.links }
            let(:expected) do
              %w(
                http://www.ift.tt/2ofZdhV
                http://feeds.wordpress.com/1.0/gocomments/josegabrielcelis.wordpress.com/1476
              )
            end

            it { is_expected.to eq(expected) }
          end

          describe "#tags" do
            subject { post.tags }
            it { is_expected.to eq(%w(Fotos Instagram)) }
          end

          describe "#images" do
            subject { post.images }
            it { is_expected.to be_empty }
          end

          describe "#indexed_at" do
            subject { post.indexed_at }
            it { is_expected.to eq(Time.parse("2017-04-10T22:00:28Z")) }
          end

          describe "#published_at" do
            subject { post.published_at }
            it { is_expected.to eq(Time.parse("2017-04-09T22:31:34Z")) }
          end

          describe "#reindexed_at" do
            subject { post.reindexed_at }
            it { is_expected.to eq(Time.parse("2017-04-10T22:00:28Z")) }
          end

          describe "#inlinks_count" do
            subject { post.inlinks_count }
            it { is_expected.to eq(0) }
          end

          describe "#blog_id" do
            subject { post.blog_id }
            it { is_expected.to eq("1811310581070495497") }
          end

          describe "#blog_name" do
            subject { post.blog_name }
            it { is_expected.to eq("José Gabriel Celis") }
          end

          describe "#blog_url" do
            subject { post.blog_url }
            it { is_expected.to eq("https://josegabrielcelis.wordpress.com") }
          end

          describe "#blog_rank" do
            subject { post.blog_rank }
            it { is_expected.to eq(1) }
          end

          describe "#authority" do
            subject { post.authority }
            it { is_expected.to eq(0) }
          end
        end
      end

      context "with a valid empty result" do
        let(:fixture) { :valid_empty }

        describe "#posts" do
          subject { result.posts }
          it { is_expected.to be_empty }
        end

        describe "#number_of_posts" do
          subject { result.number_of_posts }
          it { is_expected.to eq(0) }
        end

        describe "#first_post" do
          subject { result.first_post }
          it { is_expected.to eq(nil) }
        end

        describe "#last_post" do
          subject { result.last_post }
          it { is_expected.to eq(nil) }
        end

        describe "#next_timestamp" do
          subject { result.next_timestamp }
          it { is_expected.to eq(Time.parse("2017-04-25T22:00:00Z")) }
        end
      end

      context "with an unauthorized api key result" do
        let(:fixture) { :unauthorized_api_key }

        it "should raise AuthError" do
          expect { subject }.to raise_error(AuthError)
        end
      end

      context "with an empty api key result" do
        let(:fixture) { :empty_api_key }

        it "should raise AuthError" do
          expect { subject }.to raise_error(QueryError)
        end
      end

      context "with a 404 not found result" do
        let(:fixture) { :not_found }

        it "should raise QueryError" do
          expect { subject }.to raise_error(QueryError)
        end
      end

      context "with a service unavailable result" do
        let(:fixture) { :service_unavailable }

        it "should raise ServerError" do
          expect { subject }.to raise_error(ServerError)
        end
      end

      context "with a non XML response" do
        let(:fixture) { :non_xml }
        let(:expected_exception_message) do
          /Failed to parse response: "<html>.*/
        end

        it "should raise ServerError" do
          expect { subject }
            .to raise_error(ServerError, expected_exception_message)
        end
      end
    end
  end
end
