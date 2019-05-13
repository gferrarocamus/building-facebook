# frozen_string_literal: true

require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:user1)
    @post = @user.posts.build(content: 'Lorem ipsum')
  end

  test 'user can like post' do
    @user.save
    @post.save
    assert @post.likes.count.zero?
    assert @user.likes.count.zero?
    @post.likes.create(user_id: @user.id)
    assert @post.likes.count == 1
    # @user.likes.create(post_id: @post.id)
    assert @user.likes.count == 1
  end

  test 'user can not like the same post twice' do
    @user.save
    @post.save
    @post.likes.create(user_id: @user.id)
    assert @post.likes.count == 1
    @user.likes.create(post_id: @post.id)
    assert @user.likes.count == 1
  end
end
