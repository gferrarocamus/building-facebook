# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :new_comment, only: [:show]

  def index
    @users = User.all.includes(:sent_requests, :received_requests, :friendships)
  end

  def show
    if (@user = User.includes({ posts: [:comments] }, :sent_requests, :friendships).find_by(id: params[:id]))
      @posts = User.find_by(id: params[:id]).posts.date_sorted
    else
      redirect_to users_path
    end
  end
end
