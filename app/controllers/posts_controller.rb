# frozen_string_literal: true

# Posts Controller
class PostsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post = Post.includes(:user, :likes).find(params[:id])
  end

  def index
    @posts = Post.all.includes(:user, :likes)
    @comment = Comment.new
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
