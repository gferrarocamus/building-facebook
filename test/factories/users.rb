FactoryBot.define do
  factory :user do
    name { "User" }
    email { "user@email.com" }
    encrypted_password { "MyString" }
  end

  factory :friend do
    name { "Friend" }
    email { "friend@email.com" }
    encrypted_password { "MyString" }
  end
end
