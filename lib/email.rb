class Email

  def initialize(attributes)
    @subject = attributes[:subject]
    @text = attributes[:text]
    @to = attributes[:to]
  end


  def send
    response = Faraday.post do |request|
      request.url "https://api:key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3@api.mailgun.net/v2/barfoo.mailgun.org/messages"
      request.headers['Content-Type'] = "application/x-www-form-urlencoded"
      request.headers['Authorization'] = "Basic " + Base64.strict_encode64("api:key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3")
      request.body = URI.encode_www_form({ :from => "me@barfoo.mailgun.org",
                    :to => "#{@to}",
                    :subject => "#{@subject}",
                    :text => "#{@text}"})
    end
    puts response.body
    puts @to
    response.status
  end
end