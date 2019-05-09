# frozen_string_literal: true

# RequestsController
class RequestsController < ApplicationController

  def index
    @requests = Request.includes(:sender).find_by(receiver_id: current_user.id)
  end

  def create
    @request = Request.new(sender_id: current_user.id, receiver_id: params[:receiver_id])
    if @request.save
      flash[:notice] = 'Request sent successfully'
    else
      flash[:alert] = 'Could not sent request'
    end
    redirect_to user_path(User.find(params[:receiver_id]))
  end

  def destroy
    if Request.exists?(params[:id])
      Request.destroy(params[:id])
      flash[:notice] = 'Request canceled successfully'
    else
      flash[:alert] = 'Already canceled.'
    end

    redirect_to user_path(User.find(params[:receiver_id]))
  end
end
