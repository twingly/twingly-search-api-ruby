require 'spec_helper'

include Twingly::Analytics

describe Post do
  it { should respond_to :url }
  it { should respond_to :title }
  it { should respond_to :summary }
  it { should respond_to :language_code }
  it { should respond_to :indexed }
  it { should respond_to :published }
  it { should respond_to :blog_url }
  it { should respond_to :blog_name }
  it { should respond_to :authority }
  it { should respond_to :blog_rank }
  it { should respond_to :tags }
end