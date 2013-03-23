require './ui_helper'


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
  puts "Please enter the email of the recipient:"
  to = gets.chomp
  puts "Type a subject for the Email, or hit Enter for no subject."
  subject = gets.chomp
  puts "What text would you like to email?"
  text = gets.chomp
  puts "What is your file path?"
  files = gets.chomp
  puts "What is your file name?"
  name = gets.chomp
  attachment = [files, name]

  1.times do
    email = Email.new({:subject => subject, :text => text, :to => to, :attachment => attachment}).send_email
    if email.successful?
      email.save 
      puts "Email sent."
    else
      puts "Email failed."
    end
  end
end

def unsubscribers
  puts "Here is a list of people who have unsubscribed from your newsletter"
  Unsubscriber.list.each {|unsubscriber| puts "   #{unsubscriber.address}" }
  #puts "Take someone off the list by putting their address below:"
end

welcome