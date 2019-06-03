# frozen_string_literal: true

# RequestsController
class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests = current_user.received_requests.includes(:sender)
  end

  def create
    @request = current_user.send_request(params[:receiver_id])
    if @request.save
      flash[:success] = 'Request sent successfully'
    else
      flash[:alert] = 'Could not send request'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    return unless (request = Request.find_by(id: params[:id]))

    flash[:notice] = if request.destroy
                       'Request removed'
                     else
                       'Could not remove that request'
                     end
    redirect_back(fallback_location: users_path)
  end
end
