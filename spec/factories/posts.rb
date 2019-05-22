FactoryBot.define do
  factory :post do
    content { "MyText" }
    user
  end
end
