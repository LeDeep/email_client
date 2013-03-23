require 'spec_helper'

describe Email do
 
  context 'validations' do 
    it {should validate_presence_of :to}
    it {should validate_presence_of :subject}
    it {should validate_presence_of :text}

  end

  context '#send_email' do 
    it 'should send an email with a subject and text to an email address' do 
      VCR.use_cassette('email') do
        stub = stub_request(:post, 'https://api:key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3@api.mailgun.net/v2/barfoo.mailgun.org/messages')
        email = Email.new({'subject' => 'Cool email', 'text' => "Wassaap", 'to' => 'plowry812@gmail.com', 'attachment' => File.new(File.join("/Library/Desktop Pictures/", "Circles.jpg"))})
        email.text
        p File.new(File.join("/Library/Desktop Pictures/", "Circles.jpg"))
        email.send_email
        stub.should have_been_requested
      end
    end
  end

  context '#successful' do
    it 'validates if an email is sent succesfully' do 
      stub = stub_request(:post, 'https://api:key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3@api.mailgun.net/v2/barfoo.mailgun.org/messages').to_return(:status => 200) 
      email = Email.new({'subject' => 'Cool email', 'text' => "Wassaap", 'to' => 'plowry812@gmail.com'})
      email.send_email
      email.successful?.should be_true
    end
  end
end