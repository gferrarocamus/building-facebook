# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'MyText' }
    user
    post
  end
end
