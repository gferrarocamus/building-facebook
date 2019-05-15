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

  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def friendship(friend_id)
    current_user.friendships.find_by(friend_id: friend_id)
  end

  def get_request(id)
    current_user.sent_requests.find_by(receiver_id: id) ||
      current_user.received_requests.find_by(sender_id: id)
    # current_user.sent_requests.find_by(receiver_id: receiver_id)
  end
end
