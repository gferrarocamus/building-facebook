# frozen_string_literal: true

require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  def current_user
    users(:user_1)
  end

  test 'request_sent? returns true if it exists, false if it does not' do
    sender = users(:user_1)
    receiver = users(:user_2)
    sign_in(sender)
    assert request_sent?(receiver.id)
    assert_not request_sent?(sender.id)
  end

  # test "returns the correct request" do

  # end
end
