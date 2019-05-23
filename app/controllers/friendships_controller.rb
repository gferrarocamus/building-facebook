# frozen_string_literal: true

# FriendshipsController
class FriendshipsController < ApplicationController
  def create
    if (request = Request.find_by(sender_id: params[:friend_id], receiver_id: current_user.id))
      current_user.passive_friendships.create(active_friend_id: params[:friend_id])
      request.destroy
    end
    redirect_back(fallback_location: requests_path)
  end

  def destroy
    return unless (friendship = Friendship.find_by(id: params[:id]))

    friendship.destroy
    redirect_back(fallback_location: users_path)
  end
end
