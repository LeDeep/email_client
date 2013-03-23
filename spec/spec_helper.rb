require 'rspec'
require 'faraday'
require 'json'
require 'webmock/rspec'
require 'active_record'
require 'shoulda-matchers'
require 'vcr'
require 'pry'

require 'pg'
require 'base64'
require 'uri'

require 'email'
require 'unsubscriber'
require './env'


DOMAIN_NAME = 'barfoo.mailgun.org'
API_KEY = 'key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3'
VALID_UNSUBSCRIBER_RESPONSE = "{\n  \"total_count\": 3,\n  \"items\": [\n    {\n      \"created_at\": \"Fri, 22 Mar 2013 19:14:57 GMT\",\n      \"tag\": \"*\",\n      \"id\": \"514cadb1c0c03640e4f5a9ed\",\n      \"address\": \"zerocool@leethacker.com\"\n    },\n    {\n      \"created_at\": \"Fri, 22 Mar 2013 19:14:39 GMT\",\n      \"tag\": \"*\",\n      \"id\": \"514cad9fc0c03640e4f5a9d9\",\n      \"address\": \"elite@hacker.com\"\n    },\n    {\n      \"created_at\": \"Fri, 22 Mar 2013 19:14:18 GMT\",\n      \"tag\": \"*\",\n      \"id\": \"514cad8ac0c03640e4f5a9bf\",\n      \"address\": \"poser@fakeemail.com\"\n    }\n  ]\n}" 
USER_EMAIL = 'barfoodicus@barfoo.mailgun.org'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Email.all.each {|task| task.destroy}
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock 
end