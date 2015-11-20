require 'spec_helper'

include Twingly::Search

describe Client do
  subject { Client.new('api_key') }
  context 'with API key as arguments' do
    it { should be_a Client }
  end

  context 'with API key from ENV variable' do
    before { allow_any_instance_of(Client).to receive(:env_api_key).and_return('api_key') }
    subject { Client.new }
    it { should be_a Client }
  end

  context 'without valid API key' do
    before { allow_any_instance_of(Client).to receive(:env_api_key).and_return(nil) }
    subject { Client.new }
    it { expect { subject }.to raise_error(RuntimeError, 'Missing API key') }
  end

  describe '#query' do
    subject { Client.new('api_key').query }
    it { should be_a Query }
  end
end
