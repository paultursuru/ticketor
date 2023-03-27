namespace :generate do
  desc "add a teacher user"
  task admin: :environment do
    User.create!(email: 'admin@mail.com', username: "Admin", password: "123456", status: 2)
    puts "Admin created"
  end
  desc "add a few students"
  task students: :environment do
    users = ["joe longname", "john cool", "jane awesome", "jim carrey", "joey very much long name"]
    user_instances = users.map { |user| User.create!(email: "#{user.gsub(" ", ".")}@mail.com", password: "123456", username: user) }
  end
end
