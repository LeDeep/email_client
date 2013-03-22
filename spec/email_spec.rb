require 'spec_helper'

describe Email do
  it 'initializes with a hash as an argument' do
    email = Email.new({:subject => 'Cool email', :text => "Wassaap"})
    email.should be_an_instance_of Email
  end

  context '#send' do 
    it 'should send an email with a subject and text to an email address' do 
      stub = stub_request(:post, "https://api:key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3"\
        "@api.mailgun.net/v2/barfoo.mailgun.org/messages").to_return(:status => 200) 
      email = Email.new({:subject => 'Cool email', :text => "Wassaap", :to => 'plowry812@gmail.com'})
      email.send
      stub.should have_been_requested
    end
  end
end