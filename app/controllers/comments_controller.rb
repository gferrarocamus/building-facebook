# frozen_string_literal: true

# CommentsController
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.build(comments_params)
    flash[:alert] = 'Could not publish comment' unless comment.save
    redirect_back(fallback_location: root_path)
  end

  private

  def comments_params
    params.require(:comment).permit(:content, :post_id)
  end
end
