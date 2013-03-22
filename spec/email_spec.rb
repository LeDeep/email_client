require 'spec_helper'

describe Email do
  context '#initialize' do
    it 'initializes with a hash as an argument' do
      email = Email.new({:subject => 'Cool email', :text => "Wassaap"})
      email.should be_an_instance_of Email
    end
  end

  # context 'validations' do 
  #   it 'validates length of subject line to between 1 and 78' do
  #     email_too_short = Email.new(:subject => '')
  #     email_too_long = Email.new(:subject => '*'*79)
  #     email_just_right = Email.new(:subject => 'REMEMBER THIS EMAIL')
  #     email_too_short.valid?.should(be_false)
  #     email_too_long.valid?.should eq false      
  #     email_just_right.valid?.should eq true
  #   end

  #   it 'validates presence of body text'
  #   it 'validates to e-mail format'


  # end

  context '#send' do 
    it 'should send an email with a subject and text to an email address' do 
      stub = stub_request(:post, "https://api:key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3"\
        "@api.mailgun.net/v2/barfoo.mailgun.org/messages").to_return(:status => 200) 
      email = Email.new({:subject => 'Cool email', :text => "Wassaap", :to => 'plowry812@gmail.com'})
      email.send
      stub.should have_been_requested
    end
  end

  context '#successful' do
    it 'validates if an email is sent succesfully' do 
      stub = stub_request(:post, "https://api:key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3"\
        "@api.mailgun.net/v2/barfoo.mailgun.org/messages").to_return(:status => 200) 
      email = Email.new({:subject => 'Cool email', :text => "Wassaap", :to => 'plowry812@gmail.com'})
      email.send
      email.successful?.should be_true
    end
  end
end