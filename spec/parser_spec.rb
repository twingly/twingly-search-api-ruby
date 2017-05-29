# encoding: utf-8

require 'spec_helper'
require 'date'

include Twingly::Search

describe Parser do
  it { should respond_to(:parse) }

  describe "#parse" do
    let(:document) { Fixture.get(fixture) }
    let(:result)   { described_class.new.parse(document) }
    subject        { result }

    context "with a valid result" do
      let(:fixture) { :minimal_valid }

      it { is_expected.to be_a Result }

      describe "#number_of_matches_returned" do
        subject { result.number_of_matches_returned }
        it { is_expected.to eq(3) }
      end

      describe "#number_of_matches_total" do
        subject { result.number_of_matches_total }
        it { is_expected.to eq(3122050) }
      end

      describe "#seconds_elapsed" do
        subject { result.seconds_elapsed }
        it { is_expected.to eq(0.369) }
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
          it { is_expected.to eq("16405819479794412880") }
        end

        describe "#author" do
          subject { post.author }
          it { is_expected.to eq("klivinihemligheten") }
        end

        describe "#url" do
          subject { post.url }
          it { is_expected.to eq("http://nouw.com/klivinihemligheten/planering---men-dalig-30016048") }
        end

        describe "#title" do
          subject { post.title }
          it { is_expected.to eq("Planering - men dålig") }
        end

        describe "#text" do
          subject { post.text }
          it { is_expected.to start_with("Det vart en förmiddag på boxen med en brud som jag ") }
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
          let(:expected_tags) do
            [
              "Ätas & drickas",
              "Universitet & studentlivet",
              "Träning",
              "To to list",
            ]
          end

          it { is_expected.to eq(expected_tags) }
        end

        describe "#images" do
          subject { post.images }
          it { is_expected.to be_empty }
        end

        describe "#indexed_at" do
          subject { post.indexed_at }
          it { is_expected.to eq(Time.parse("2017-05-04T06:51:23Z")) }
        end

        describe "#published_at" do
          subject { post.published_at }
          it { is_expected.to eq(Time.parse("2017-05-04T06:50:59Z")) }
        end

        describe "#reindexed_at" do
          subject { post.reindexed_at }
          it { is_expected.to eq(Time.parse("2017-05-04T08:51:23Z")) }
        end

        describe "#inlinks_count" do
          subject { post.inlinks_count }
          it { is_expected.to eq(0) }
        end

        describe "#blog_id" do
          subject { post.blog_id }
          it { is_expected.to eq("5312283800049632348") }
        end

        describe "#blog_name" do
          subject { post.blog_name }
          it { is_expected.to eq("Love life like a student") }
        end

        describe "#blog_url" do
          subject { post.blog_url }
          it { is_expected.to eq("http://nouw.com/klivinihemligheten") }
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

      describe "#posts.last" do
        subject(:post) { result.posts.last }

        describe "#id" do
          subject { post.id }
          it { is_expected.to eq("2770252465384762934") }
        end

        describe "#author" do
          subject { post.author }
          it { is_expected.to eq("maartiinasvardag") }
        end

        describe "#url" do
          subject { post.url }
          it { is_expected.to eq("http://nouw.com/maartiinasvardag/god-formiddag-30016041") }
        end

        describe "#title" do
          subject { post.title }
          it { is_expected.to eq("God förmiddag! ☀️") }
        end

        describe "#text" do
          subject { post.text }
          it { is_expected.to start_with("Hmm.... Vad ska man börja ??  Jag vet inte riktigt vad min gnista ") }
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
          it { is_expected.to be_empty }
        end

        describe "#images" do
          subject { post.images }
          it { is_expected.to be_empty }
        end

        describe "#indexed_at" do
          subject { post.indexed_at }
          it { is_expected.to eq(Time.parse("2017-05-04T06:50:07Z")) }
        end

        describe "#published_at" do
          subject { post.published_at }
          it { is_expected.to eq(Time.parse("2017-05-04T06:49:50Z")) }
        end

        describe "#reindexed_at" do
          subject { post.reindexed_at }
          it { is_expected.to eq(Time.parse("0001-01-01T00:00:00Z")) }
        end

        describe "#inlinks_count" do
          subject { post.inlinks_count }
          it { is_expected.to eq(0) }
        end

        describe "#blog_id" do
          subject { post.blog_id }
          it { is_expected.to eq("1578135310841173675") }
        end

        describe "#blog_name" do
          subject { post.blog_name }
          it { is_expected.to eq("maartiinasvardag blogg") }
        end

        describe "#blog_url" do
          subject { post.blog_url }
          it { is_expected.to eq("http://nouw.com/maartiinasvardag") }
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

    context "with a valid result containing links" do
      let(:fixture) { :valid_links }

      describe "#posts.first" do
        subject(:post) { result.posts.first }
        let(:expected_links) do
          %w[
            https://1.bp.blogspot.com/-4uNjjiNQiug/WKguo1sBxwI/AAAAAAAAqKE/_eR7cY8Ft3cd2fYCx-2yXK8AwSHE_A2GgCLcB/s1600/aaea427ee3eaaf8f47d650f48fdf1242.jpg
            http://www.irsn.fr/EN/newsroom/News/Pages/20170213_Detection-of-radioactive-iodine-at-trace-levels-in-Europe-in-January-2017.aspx
            https://www.t.co/2P4IDmovzH
            https://www.twitter.com/Strat2Intel/status/832710701730844672
          ]
        end

        describe "#links" do
          its(:links) { should eq(expected_links) }
        end
      end
    end

    context "with a valid result containing coordinates" do
      let(:fixture) { :valid_coordinates }

      describe "#posts.first" do
        subject(:post) { result.posts.first }
        let(:expected_coordinates) do
          {
            latitude:  49.1,
            longitude: 10.75,
          }
        end

        describe "#coordinates" do
          its(:coordinates) { should eq(expected_coordinates) }
        end
      end
    end

    context "with a valid empty result" do
      let(:fixture) { :valid_empty }

      it "should return an empty result" do
        expect(subject.posts.size).to eq(0)
        expect(subject.number_of_matches_total).to eq(0)
        expect(subject.number_of_matches_returned).to eq(0)
      end
    end

    context "with an complete result" do
      let(:fixture) { :valid_empty }

      it { is_expected.not_to be_incomplete }
    end

    context "with an incomplete result" do
      let(:fixture) { :incomplete }

      it { is_expected.to be_incomplete }
    end

    context "with a nonexistent api key result" do
      let(:fixture) { :nonexistent_api_key }

      it "should raise AuthError" do
        expect { subject }.to raise_error(QueryError)
      end
    end

    context "with an unauthorized api key result" do
      let(:fixture) { :unauthorized_api_key }

      it "should raise AuthError" do
        expect { subject }.to raise_error(AuthError)
      end
    end

    context "with a service unavailable result" do
      let(:fixture) { :service_unavailable }

      it "should raise ServerError" do
        expect { subject }.to raise_error(ServerError)
      end
    end

    context "with a undefined error result" do
      let(:fixture) { :undefined_error }

      it "should raise ServerError" do
        expect { subject }.to raise_error(ServerError)
      end
    end

    context "with a undefined error result" do
      let(:fixture) { :non_xml }

      it "should raise ServerError" do
        expect { subject }.to raise_error(ServerError, /503 Service Unavailable/)
      end
    end
  end
end
