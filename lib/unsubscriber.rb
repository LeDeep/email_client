class Unsubscriber

  attr_reader :address

  def initialize(attributes)
    @address = attributes['address']
    @id = attributes['id']
  end

  def self.list
    response = Faraday.get do |request|
      request.url "https://api:#{KEY}@api.mailgun.net/v2/#{DOMAIN}/unsubscribes"
      request.headers['Content-Type'] = "application/x-www-form-urlencoded"
      request.headers['Authorization'] = "Basic " + Base64.strict_encode64("api:#{KEY}")
    end
    body = JSON.parse(response.body) if response.body
    body['items'].map {|unsubscriber| Unsubscriber.new(unsubscriber) }
   
  end

end
