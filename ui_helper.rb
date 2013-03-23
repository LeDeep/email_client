require 'faraday'
require 'base64'
require 'uri'
require 'json'
require 'active_record'

require './lib/email'
require './lib/unsubscriber'
require './env'


DOMAIN_NAME = 'barfoo.mailgun.org'
API_KEY = 'key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3'
USER_EMAIL = 'barfoodicus@barfoo.mailgun.org'
database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuation = database_configurations["development"]
ActiveRecord::Base.establish_connection(development_configuation)