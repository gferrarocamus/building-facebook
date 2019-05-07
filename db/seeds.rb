# frozen_string_literal: true

# seeding
10.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  User.create!(
    name: name,
    email: email,
    password: '123456'
  )
end

3.times do |n|
  user = User.find(n+1)
  user.friends << User.find(n+2)
  user.friends << User.find(n+3) if n%2==0
end

# users = User.all
# 10.times do |n|
#   users.each do |user|
#     user.created_events.create!(description: "#{user.name}'s Event n.#{n + 1}")
#   end
# end