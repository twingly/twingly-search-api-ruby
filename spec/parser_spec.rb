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
      let(:fixture) { :valid }

      it { is_expected.to be_a Result }
    end

    context "with a minimal valid result" do
      let(:fixture) { :minimal_valid }

      describe "#posts[0]" do
        let(:post) { result.posts[0] }

        describe "#url" do
          subject { post.url }
          it { is_expected.to eq("http://oppogner.blogg.no/1409602010_bare_m_ha.html") }
        end

        describe "#title" do
          subject { post.title }
          it { is_expected.to eq("Bare MÅ ha!") }
        end

        describe "#summary" do
          subject { post.summary }
          it { is_expected.to eq("Ja, velkommen til høsten ...") }
        end

        describe "#language_code" do
          subject { post.language_code }
          it { is_expected.to eq("no") }
        end

        describe "#published" do
          subject { post.published }
          it { is_expected.to eq(DateTime.parse("2014-09-02 06:53:26Z")) }
        end

        describe "#indexed" do
          subject { post.indexed }
          it { is_expected.to eq(DateTime.parse("2014-09-02 09:00:53Z")) }
        end

        describe "#blog_url" do
          subject { post.blog_url }
          it { is_expected.to eq("http://oppogner.blogg.no/") }
        end

        describe "#authority" do
          subject { post.authority }
          it { is_expected.to eq(1) }
        end

        describe "#blog_rank" do
          subject { post.blog_rank }
          it { is_expected.to eq(1) }
        end

        describe "#tags" do
          subject { post.tags }
          it { is_expected.to eq(["Blogg"]) }
        end
      end

      describe "#posts[1]" do
        let(:post) { result.posts[1] }

        describe "#url" do
          subject { post.url }
          it { is_expected.to eq("http://www.skvallernytt.se/hardtraning-da-galler-swedish-house-mafia") }
        end

        describe "#title" do
          subject { post.title }
          it { is_expected.to eq("Hårdträning – då gäller Swedish House Mafia") }
        end

        describe "#summary" do
          subject { post.summary }
          it { is_expected.to eq("Träning. Och Swedish House Mafia. Det verkar vara ett lyckat koncept. \"Don't you worry child\" och \"Greyhound\" är nämligen de två mest spelade träningslåtarna under januari 2013 på Spotify.

Relaterade inlägg:
Swedish House Mafia – ny låt!
Ny knivattack på Swedish House Mafia-konsert
Swedish House Mafia gör succé i USA") }
        end

        describe "#language_code" do
          subject { post.language_code }
          it { is_expected.to eq("sv") }
        end

        describe "#published" do
          subject { post.published }
          it { is_expected.to eq(DateTime.parse("2013-01-29 15:21:56Z")) }
        end

        describe "#indexed" do
          subject { post.indexed }
          it { is_expected.to eq(DateTime.parse("2013-01-29 15:22:52Z")) }
        end

        describe "#blog_url" do
          subject { post.blog_url }
          it { is_expected.to eq("http://www.skvallernytt.se/") }
        end

        describe "#authority" do
          subject { post.authority }
          it { is_expected.to eq(38) }
        end

        describe "#blog_rank" do
          subject { post.blog_rank }
          it { is_expected.to eq(4) }
        end

        describe "#tags" do
          subject { post.tags }
          it { is_expected.to eq(["Okategoriserat", "Träning", "greyhound", "koncept", "mafia"]) }
        end
      end

      describe "#posts[2]" do
        let(:post) { result.posts[2] }

        describe "#url" do
          subject { post.url }
          it { is_expected.to eq("http://didriksinspesielleverden.blogg.no/1359472349_justin_bieber.html") }
        end

        describe "#title" do
          subject { post.title }
          it { is_expected.to eq("Justin Bieber") }
        end

        describe "#summary" do
          subject { post.summary }
          it { is_expected.to eq("OMG! Justin Bieber Believe acoustic albumet er nå ute på spotify. Han er helt super. Love him. Personlig liker jeg best beauty and a beat og as long as you love me, kommenter gjerne hva dere synes! <3 #sus YOLO") }
        end

        describe "#language_code" do
          subject { post.language_code }
          it { is_expected.to eq("no") }
        end

        describe "#published" do
          subject { post.published }
          it { is_expected.to eq(DateTime.parse("2013-01-29 15:12:29Z")) }
        end

        describe "#indexed" do
          subject { post.indexed }
          it { is_expected.to eq(DateTime.parse("2013-01-29 15:14:37Z")) }
        end

        describe "#blog_url" do
          subject { post.blog_url }
          it { is_expected.to eq("http://didriksinspesielleverden.blogg.no/") }
        end

        describe "#authority" do
          subject { post.authority }
          it { is_expected.to eq(0) }
        end

        describe "#blog_rank" do
          subject { post.blog_rank }
          it { is_expected.to eq(1) }
        end

        describe "#tags" do
          subject { post.tags }
          it { is_expected.to eq([]) }
        end
      end
    end

    context "with a valid result containing non-blogs" do
      let(:fixture) { :valid_non_blog }

      it "should exclude the non-blog entries" do
        expect(subject.posts.size).to eq(1)
      end
    end

    context "with a nonexistent api key result" do
      let(:fixture) { :nonexistent_api_key }

      it "should raise AuthError" do
        expect { subject }.to raise_error(AuthError)
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
