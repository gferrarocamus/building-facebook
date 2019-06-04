# frozen_string_literal: true

# Request Model
class Request < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :sender_id, uniqueness: { scope: :receiver_id }

  before_validation :check_inverse
  before_validation :stop_requests_from_friends

  private

  def check_inverse
    return unless Request.exists?(sender_id: receiver.id, receiver_id: sender.id)

    self.sender, self.receiver = receiver, sender
  end

  def stop_requests_from_friends
    return unless Friendship.exists?(active_friend_id: sender.id, passive_friend_id: receiver.id) ||
                  Friendship.exists?(passive_friend_id: sender.id, active_friend_id: receiver.id)

    errors[:receiver] << 'is already your friend!'
  end
end
