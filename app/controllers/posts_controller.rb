# frozen_string_literal: true

# Posts Controller
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :new_comment, only: [:show, :index]

  def show
    @post = Post.date_sorted.includes(:user, :likes, comments: [:user]).find(params[:id])
  end

  def index
    @posts = Post.date_sorted.all.includes(:user, :likes, comments: [:user])
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

  def new_comment
    @comment = Comment.new
  end
end
