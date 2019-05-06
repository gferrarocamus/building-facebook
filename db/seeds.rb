# frozen_string_literal: true

# seeding
10.times do
  name = Faker::Name.name
  User.create!(
    name: name
  )
end

# users = User.all
# 10.times do |n|
#   users.each do |user|
#     user.created_events.create!(description: "#{user.name}'s Event n.#{n + 1}")
#   end
# end