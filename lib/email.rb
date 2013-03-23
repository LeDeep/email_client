class Email < ActiveRecord::Base

  attr_accessor :attachment

  validates :subject, :length => { :in => 1..78 }
  validates :to, :subject, :text, :presence => true 

  def send_email
    params = {
      "from" => USER_EMAIL,
      "to" => to,
      "subject" => subject,
      "text" => text,
      "attachment" => File.new(File.join(*attachment))
        }
    conn = Faraday.new(:url => 'https://api.mailgun.net/v2') do |faraday|
      faraday.request  :url_encoded
      #faraday.response :logger
      faraday.adapter  Faraday.default_adapter 
    end
    conn.basic_auth('api', API_KEY)
    response = conn.post("#{DOMAIN_NAME}/messages", params)
    @status = response.status
    self
    end

  def successful?
    @status == 200
  end
end