# frozen_string_literal: true

require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  # include Devise::Test::IntegrationHelpers
  # include UsersHelper
  
  # test "request_sent? returns true if it exists, false if it does not" do
  #   sender = users(:user_1)
  #   receiver = users(:user_2)
  #   sign_in(sender)
  #   assert request_sent?(receiver.id)
  #   assert_not request_sent?(sender.id)
  # end

  test 'should show a flash after new request' do
    sign_in(users(:user1))
    get user_path(users(:user2))
    post requests_path
    assert_not flash.empty?
  end
end
