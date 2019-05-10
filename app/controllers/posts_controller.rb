# frozen_string_literal: true

# Posts Controller
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :new_comment, only: %i[show index]

  def show
    @post = Post.date_sorted.includes(:user, :likes, comments: [:user]).find(params[:id])
  end

  def index
    friends = current_user.friends.pluck('friend_id') + [current_user.id]
    @posts = Post.date_sorted.where(user_id: friends).includes(:user, :likes, comments: [:user])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      flash[:notice] = 'Post created successfully.'
      redirect_to @post
    else
      render 'new'
    end
  end

  private

  def posts_params
    params.require(:post).permit(:content)
  end
end
