# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  def destroy_request(sender_id, receiver_id)
    return unless (request = Request.find_by(sender_id: sender_id, receiver_id: receiver_id))

    request.destroy
    redirect_back(fallback_location: user_path(User.find(receiver_id)))
  end

  protected

  def new_comment
    @comment = Comment.new
  end
end
