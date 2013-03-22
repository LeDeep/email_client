require 'faraday'
require 'base64'
require 'uri'
require 'json'
require 'active_model'

require './lib/email'
require './lib/unsubscriber'
require './env'


def welcome
  puts "Welcome to the EMAILER."
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "What would you like to do?"
    puts "Press 's' to send an email."
    puts "Press 'u' to see a list of unsubscribers from our awesome newsletter."
    puts "Press 'e' to exit."
    case choice = gets.chomp
    when 's'
      send_email
    when 'u'
      unsubscribers
    when 'e'
      exit
    else
      invalid
    end
  end
end

def send_email
  puts "Type a subject for the Email, or hit Enter for no subject."
  subject = gets.chomp
  puts "What text would you like to email?"
  text = gets.chomp
  puts "Please enter the email of the recipient:"
  to = gets.chomp
  
  email = Email.new({:subject => subject, :text => text, :to => to})
  if email.successful?
    puts "Email sent."
  else
    puts "Email failed."
  end
end

def unsubscribers
  puts "Here is a list of people who have unsubscribed from your newsletter"
  Unsubscriber.list.each {|unsubscriber| puts "   #{unsubscriber.address}" }
  #puts "Take someone off the list by putting their address below:"
end

welcome