# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    before(:create) { |f| create(:request, sender_id: f.active_friend.id, receiver_id: f.passive_friend.id) }

    active_friend
    passive_friend
  end
end
