# frozen_string_literal: true

# CommentsController
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @c = current_user.comments.create(comments_params)
    flash[:notice] = @c.errors.full_messages
    redirect_back(fallback_location: root_path)
  end

  private

  def comments_params
    params.require(:comment).permit(:content, :post_id)
  end
end
