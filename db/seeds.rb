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

5.times do |n|
  sender = User.last
  receiver = User.find(n+1)
  sender.receivers << receiver
end

3.times do |n|
  user = User.find(n+1)
  user.active_friends << User.find(n+2)
  user.passive_friends << User.find(n+3) if n%2==0
end

7.times do |n|
  user = User.find(n+1)
  3.times do |i|
    user.posts << Post.new(content: "This is post ##{i+1} from #{user.name}") if n%2==0
    if (friend = user.friends[i])
      friend.comments.create(content: 'Lorem ipsum', post: user.posts.first)
      friend.likes.create(post: user.posts.first) if i%2==0
    end
  end
end