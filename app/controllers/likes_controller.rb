# frozen_string_literal: true

# LikesController
class LikesController < ApplicationController
  def create
    Post.find_by(id: params[:id]).likes.create(user_id: current_user.id)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like = Like.find_by(id: params[:id])
    like&.destroy
    redirect_back(fallback_location: root_path)
  end
end
