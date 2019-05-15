# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect to login if not logged in' do
    get users_path
    assert_redirected_to user_session_path
  end
end
