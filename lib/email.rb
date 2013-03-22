class Email 
  include ActiveModel::Validations

  validates :subject, :presence => true,
                      :length => { :in => 1..78 }

  attr_reader :subject

  def initialize(attributes)
    @subject = attributes[:subject]
    @text = attributes[:text]
    @to = attributes[:to]
  end

  def send
    response = Faraday.post do |request|
      request.url "https://api:#{KEY}@api.mailgun.net/v2/#{DOMAIN}/messages"
      request.headers['Content-Type'] = "application/x-www-form-urlencoded"
      request.headers['Authorization'] = "Basic " + Base64.strict_encode64("api:#{KEY}")
      request.body = URI.encode_www_form({ :from => "me@#{DOMAIN}",
                    :to => "#{@to}",
                    :subject => "#{@subject}",
                    :text => "#{@text}"})
    end
    @status = response.status
  end

  def successful?
    @status == 200
  end
end