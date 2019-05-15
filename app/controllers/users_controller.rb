# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :new_comment, only: [:show]

  helper_method :friendship_id, :request_id

  def index
    @users = User.all.includes(:sent_requests, :received_requests, :friendships)
  end

  def show
    if (@user = User.includes({ posts: [:comments] }, :sent_requests, :friendships).find_by(id: params[:id]))
      @request = (
        current_user.sent_requests.find_by(receiver_id: params[:id]) || 
        current_user.received_requests.find_by(sender_id: params[:id]) 
      )
      @friendship = current_user.friendships.find_by(friend_id: params[:id])
      @posts = User.find_by(id: params[:id]).posts.date_sorted
    else
      redirect_to users_path
    end
  end

  def friendship_id(friend_id)
    current_user.friendships.find_by(friend_id: friend_id).id
  end

  def request_id(receiver_id)
    current_user.sent_requests.find_by(receiver_id: receiver_id).id
  end
end
