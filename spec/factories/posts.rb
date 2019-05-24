# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    content { "Post by User # #{user.id}" }
    user
  end
end
