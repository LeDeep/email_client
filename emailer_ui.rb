require './lib/email'
require 'faraday'
require 'base64'
require 'uri'



def welcome
  puts "Welcome to the EMAILER."
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "What would you like to do?"
    puts "Press 's' to send an email."
    puts "Press 'e' to exit."
    case choice = gets.chomp
    when 's'
      send_email
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
  if email.send == 200
    puts "Send successful."
  else
    puts "Send failed."
  end 
end

welcome