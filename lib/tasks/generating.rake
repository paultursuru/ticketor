namespace :generate do
  desc "add a teacher user"
  task admin: :environment do
    User.create!(email: 'admin@mail.com', username: "Admin", password: "123456", status: 2)
    puts "Admin created"
  end
  desc "add a few students"
  task students: :environment do
    users = ["joe longname", "john cool", "jane awesome", "jim carrey", "joey very much long name"]
    users.each { |user| User.create!(email: "#{user.gsub(" ", ".")}@mail.com", password: "123456", username: user) }
  end
  desc "add next session students"
  task next_session_students: :environment do
    require 'json'
    require 'open-uri'
    students = JSON.parse(File.read(Rails.root.join('lib', 'assets', 'students.json'))).dig("students")
    students.each do |user|
      User.new(email: user.dig("email"), password: "123456", username: user.dig("name")).save!
      puts "created student #{user.dig("name")}"
    end
  end
end
