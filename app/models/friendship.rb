# frozen_string_literal: true

# Friendship Model
class Friendship < ApplicationRecord
  belongs_to :passive_friend, class_name: 'User'
  belongs_to :active_friend, class_name: 'User'

  validates :active_friend_id, uniqueness: { scope: :passive_friend_id }

  before_validation :check_inverse

  private

  def check_inverse
    return unless Friendship.exists?(active_friend_id: passive_friend.id, passive_friend_id: active_friend.id)

    self.active_friend, self.passive_friend = passive_friend, active_friend
  end
end
