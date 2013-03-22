require 'spec_helper'

describe Unsubscriber do 
  let(:list_stub) { stub = stub_request(:get, "https://api:#{KEY}"\
        "@api.mailgun.net/v2/#{DOMAIN}/unsubscribes").to_return(:status => 200, :body => VALID_UNSUBSCRIBER_RESPONSE ) }

  context '#initializes' do
    it 'initializes an instance of an unsubscriber with a hash of values' do 
      unsubscriber = Unsubscriber.new('address' => 'plowry812@gmail.com')
      unsubscriber.should be_an_instance_of Unsubscriber 
    end
  end 

  context 'readers' do
    it 'reads the address' do 
      unsubscriber = Unsubscriber.new('address' => 'plowry812@gmail.com')
      unsubscriber.address.should eq 'plowry812@gmail.com'
    end
  end

  context '#list' do
    it 'GETs a list of unsubscriber objects' do
      stub = list_stub
      Unsubscriber.list
      stub.should have_been_requested
    end
    it 'returns an array of unsubscriber objects' do 
      list_stub
      unsubscribers = Unsubscriber.list
      emails = unsubscribers.map { |unsubscriber| unsubscriber.address }
      emails.should eq ['zerocool@leethacker.com','elite@hacker.com','poser@fakeemail.com']
    end
  end
end