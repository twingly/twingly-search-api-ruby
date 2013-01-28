require 'spec_helper'

include Twingly::Analytics

describe Parser do
  it { should respond_to(:parse) }

  describe "#parse" do
    subject { Parser.new }

    context "with valid result" do
      let(:document) { File.read('spec/fixtures/valid_result.xml') }

      it "should parse document" do
        subject.parse(document).should be_a Result
      end

      # TODO testa någon annanstans
      it "should return number of results" do
        subject.parse(document).number_of_documents.should == 756
      end

      it "should return posts" do
        subject.parse(document).posts.should be_a Array
      end

      it "should return post" do
        subject.parse(document).posts.first.should be_a Post
      end

      describe "Post" do
        subject { Parser.new.parse(document).posts.first }
        it { should respond_to :url }
        it { should respond_to :title }
        it { should respond_to :summary }
        it { should respond_to :language_code }
        it { should respond_to :date }
        it { should respond_to :blog_url }
        it { should respond_to :blog_name }
        it { should respond_to :authority }
      end
    end
  end
end