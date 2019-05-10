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

  def like_exists?(post_id)
    Like.exists?(user_id: current_user.id, post_id: post_id)
  end

  def like(post_id)
    Like.find_by(user_id: current_user.id, post_id: post_id)
  end
end
