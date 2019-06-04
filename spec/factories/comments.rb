# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { "Comment by User # #{user.id}" }
    user
    post
  end
end
