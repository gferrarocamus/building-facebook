# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :new_comment, only: [:show]

  def index
    @users = User.all
  end

  def show
    if (@user = User.includes({ posts: [:comments] }, :sent_requests, :friendships).find_by(id: params[:id]))
      @request = current_user.sent_requests.find_by(receiver_id: params[:id])
      @friendship = current_user.friendships.find_by(friend_id: params[:id])
      @posts = User.find_by(id: params[:id]).posts.date_sorted
    else
      redirect_to users_path
    end
  end
end
