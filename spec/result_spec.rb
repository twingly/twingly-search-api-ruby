require 'spec_helper'
require 'uri'

include Twingly::Analytics

describe Result do
  it { should respond_to :posts }
  it { should respond_to :number_of_documents }
end
