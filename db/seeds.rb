
User.destroy_all

User.create!(email: 'paul@mail.com', username: "Paulo", password: "123456", status: 2)
User.create!(email: 'pablo@mail.com', username: "Pablo", password: "123456", status: 1)
User.create!(email: 'paolito@mail.com', username: "Paolito", password: "123456", status: 1)

users = ["joe", "john", "jane", "jim", "joey"]

user_instances = users.map { |user| User.create!(email: "#{user}@mail.com", password: "123456", username: user) }
user_instances.each { |user| Ticket.create!(user: user,
                                            content: "my name is #{user.username} and my email is #{user.email}",
                                            teacher: User.ticketable.sample) }
