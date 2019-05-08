# frozen_string_literal: true

module UsersHelper
  def request_sent?(id)
    Request.exists?(sender_id: current_user.id, receiver_id: id)
  end

  def request_received?(id)
    Request.exists?(receiver_id: current_user.id, sender_id: id)
  end
end
