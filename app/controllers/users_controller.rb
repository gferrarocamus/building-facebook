# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :new_comment, only: [:show]

  def index
    @users = User.all.index_associations
  end

  def show
    if (@user = User.show_associations.find_by(id: params[:id]))
      @posts = User.get_posts(params[:id])
    else
      redirect_to users_path
    end
  end
end
