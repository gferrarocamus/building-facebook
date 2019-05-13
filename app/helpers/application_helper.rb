# frozen_string_literal: true

# ApplicationHelper module
module ApplicationHelper
  def requests_count
    current_user.received_requests.count
  end
end
