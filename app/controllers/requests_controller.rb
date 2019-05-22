# frozen_string_literal: true

# RequestsController
class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests = Request.includes(:sender).where(receiver_id: current_user.id)
  end

  def create
    @request = Request.new(sender_id: current_user.id, receiver_id: params[:receiver_id])
    if @request.save
      flash[:notice] = 'Request sent successfully'
    else
      flash[:alert] = 'Could not sent request'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    return unless (request = Request.find_by(id: params[:id]))

    receiver_id = request.receiver_id
    request.destroy
    redirect_back(fallback_location: user_path(User.find(receiver_id)))
  end
end
