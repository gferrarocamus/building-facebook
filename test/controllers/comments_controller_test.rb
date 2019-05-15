require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should show a flash after failing new comment' do
    sign_in(users(:user1))
    post = Post.create(content: "Lorem", user_id: users(:user2).id)
    get user_path(users(:user2))
    post comments_path(params: { comment: { content: '', post_id: post.id } })
    assert_not flash.empty?
  end
end
