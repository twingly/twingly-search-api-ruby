require 'spec_helper'
require 'uri'

include Twingly::Analytics

describe Result do
  it { should respond_to :posts }
end
