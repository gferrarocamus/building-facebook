# Defines a new sequence
FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
  sequence :name do |n|
    "User #{n}"
  end
  factory :user, aliases: [:friend, :sender, :receiver] do
    email
    name
    password { "MyString" }
  end
end
