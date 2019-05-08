class RequestsController < ApplicationController

  def create
    @request = Request.new({sender_id: current_user.id, receiver_id: params[:receiver_id]})
    if @request.save
      flash[:notice] = "Request sent successfully"
    else
      flash[:alert] = "Could not sent request"      
    end
    redirect_to user_path(User.find(params[:receiver_id]))
  end

  def destroy
  end

end
