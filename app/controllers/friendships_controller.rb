class FriendshipsController < ApplicationController
  def create
    if (request = Request.find_by(sender_id: params[:friend_id], receiver_id: current_user.id))
      current_user.friendships.create(friend_id: params[:friend_id])
      request.destroy
    end
    redirect_back(fallback_location: requests_path)
  end

  def destroy
    
  end
end
