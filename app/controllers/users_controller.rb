# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :sign_in_user

  def index
    @users = User.all
  end

  def show
    id = params[:id]
    if id
      @request = current_user.sent_requests.find_by(receiver_id: id)
      @user = User.find(id)
    else
      @user = current_user
    end
  end

  protected

  def sign_in_user
    return if user_signed_in?

    flash[:alert] = 'You need to sign in to proceed.'
    redirect_to new_user_session_path
  end

end
