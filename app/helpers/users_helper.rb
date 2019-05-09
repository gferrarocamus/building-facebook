# frozen_string_literal: true

module UsersHelper
  def request_sent?(id)
    Request.exists?(sender_id: current_user.id, receiver_id: id)
  end

  def request_received?(id)
    Request.exists?(receiver_id: current_user.id, sender_id: id)
  end

  def friendship_exists?(friend_id)
    Friendship.exists?(user_id: current_user.id, friend_id: friend_id)
  end
end
