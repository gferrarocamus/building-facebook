# frozen_string_literal: true

require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  # include Devise::Test::IntegrationHelpers

  test 'should show a flash after new request' do
    sign_in(users(:user1))
    get user_path(users(:user2))
    post requests_path
    assert_not flash.empty?
  end
end
