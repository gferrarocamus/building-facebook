# frozen_string_literal: true

# FriendshipsController
class FriendshipsController < ApplicationController
  def create
    friendship = current_user.accept_friend(params[:friend_id])
    if friendship.request?
      flash[:success] = 'You are now friends' if friendship.save
    else
      flash[:notice] = 'No request found'
    end
    redirect_back(fallback_location: requests_path)
  end

  def destroy
    return unless (friendship = Friendship.find_by(id: params[:id]))

    flash[:notice] = if friendship.destroy
                       "You're not friends anymore!"
                     else
                       'Could not unfriend that person'
                     end
    redirect_back(fallback_location: users_path)
  end
end
