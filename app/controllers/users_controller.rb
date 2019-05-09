# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    if (@user = User.includes(:sent_requests, :friendships).find_by(id: params[:id]))
      @request = current_user.sent_requests.find_by(receiver_id: params[:id])
      @friendship = current_user.friendships.find_by(friend_id: params[:id])
    else
      redirect_to users_path
    end
  end

  protected

  # def sign_in_user
  #   return if user_signed_in?

  #   flash[:alert] = 'You need to sign in to proceed.'
  #   redirect_to new_user_session_path
  # end

end
