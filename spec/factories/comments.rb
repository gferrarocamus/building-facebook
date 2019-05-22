FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user
    post
  end
end