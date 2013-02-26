require 'spec_helper'

include Twingly::Analytics

describe Client do
  subject { Client.new('api_key') }
  context 'with APi key as arguments' do
    it { should be_a Client }
  end

  context 'with API key from ENV variable' do
    before { Client.any_instance.stub(:env_api_key).and_return('api_key') }
    subject { Client.new }
    it { should be_a Client }
  end

  context 'without valid API key' do
    before { Client.any_instance.stub(:env_api_key).and_return(nil) }
    subject { Client.new }
    it { expect { subject }.to raise_error(RuntimeError, 'Missing API key') }
  end

  describe '#query' do
    subject { Client.new.query }
    it { should be_a Query }
  end
end