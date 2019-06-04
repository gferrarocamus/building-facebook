# frozen_string_literal: true

# ApplicationHelper module
module ApplicationHelper
  def get_title(title = '')
    title.empty? ? 'Social Network' : "#{title} | Social Network"
  end

  def requests_count
    current_user.received_requests.count
  end
end
