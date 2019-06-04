# frozen_string_literal: true

# Posts Controller
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :new_comment, only: %i[show index]

  def show
    @post = Post.with_associations.find(params[:id])
  end

  def index
    @posts = current_user.feed_posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      flash[:success] = 'Post created successfully.'
      redirect_to @post
    else
      flash[:notice] = 'Content should not be empty.'
      redirect_back(fallback_location: new_post_path)
    end
  end

  private

  def posts_params
    params.require(:post).permit(:content)
  end
end
