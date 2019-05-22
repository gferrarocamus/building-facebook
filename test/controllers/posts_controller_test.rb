# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  # include Devise::Test::IntegrationHelpers

  test 'should redirect to login if not logged in' do
    get posts_path
    assert_redirected_to user_session_path
  end

  test 'should get new' do
    sign_in(users(:user1))
    get new_post_path
    assert_response :success
  end
end
