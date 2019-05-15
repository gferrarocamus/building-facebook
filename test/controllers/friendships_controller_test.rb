require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  # include Devise::Test::IntegrationHelpers  
  
  test "create should redirect to requests page" do
    sign_in(users(:user_1))
    post friendships_path
    assert_redirected_to requests_path
  end

  test "destroy should redirect to friend show page" do
    sign_in(users(:user_1))
    delete friendship_path(friendships(:one))
    assert_redirected_to user_path(users(:user_2))
  end
end
