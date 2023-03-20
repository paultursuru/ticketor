namespace :remove do
  desc 'Removes all tickets'
  task tickets: :environment do
    puts "removing #{Ticket.count} tickets"
    Ticket.destroy_all
  end
  desc 'Removes all homeworks'
  task homeworks: :environment do
    puts "removing #{Homework.count} homeworks"
    Homework.destroy_all
  end
  desc 'Removes all students'
  task students: :environment do
    User.student.each do |user|
      puts "rm #{user.username} and tickets"
      user.tickets.destroy_all
      user.destroy
    end
  end
  desc 'Removes all assistants'
  task assistants: :environment do
    puts "removing all tickets"
    Ticket.destroy_all
    User.assistant.each do |user|
      puts "rm #{user.username} and tickets"
      user.tickets.destroy_all
      user.destroy
    end
  end
  desc 'Literally remove everyone'
  task everyone: :environment do
    puts "removing #{Ticket.count} tickets and #{User.count} users"
    Ticket.destroy_all
    User.all.each do |user|
      puts "rm #{user.status} #{user.username}"
      user.destroy
    end
  end
end


