# frozen_string_literal: true

# UsersHelper
module UsersHelper
  def request_sent?(id)
    Request.exists?(sender_id: current_user.id, receiver_id: id)
  end

  def request_received?(id)
    Request.exists?(receiver_id: current_user.id, sender_id: id)
  end

  def friendship_exists?(friend_id)
    Friendship.exists?(active_friend_id: current_user.id, passive_friend_id: friend_id) ||
      Friendship.exists?(passive_friend_id: current_user.id, active_friend_id: friend_id)
  end

  def like_exists?(post_id)
    Like.exists?(user_id: current_user.id, post_id: post_id)
  end

  def like(post_id)
    Like.find_by(user_id: current_user.id, post_id: post_id)
  end

  def gravatar_for(user, options = { size: 100 })
    size = options[:size]
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  def get_friendship(friend_id)
    current_user.active_friendships.find_by(passive_friend_id: friend_id) ||
      current_user.passive_friendships.find_by(active_friend_id: friend_id)
  end

  def get_request(id)
    current_user.sent_requests.find_by(receiver_id: id) ||
      current_user.received_requests.find_by(sender_id: id)
  end
end
