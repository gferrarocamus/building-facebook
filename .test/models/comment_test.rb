# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:user1)
    @user.save
    @post = @user.posts.create(content: 'Lorem ipsum')
  end

  test 'should be valid' do
    comment = @post.comments.create(content: 'Great post', user_id: @user.id)
    assert comment.valid?
  end

  test 'comment content should be present' do
    comment = @post.comments.create(content: '', user_id: @user.id)
    assert_not comment.valid?
  end

  test 'user can comment post' do
    assert @post.comments.count.zero?
    assert @user.comments.count.zero?
    assert_difference 'Comment.count', +1 do
      @post.comments.create(user_id: @user.id, content: 'Another comment')
    end
    assert @post.comments.count == 1
    assert @user.comments.count == 1
  end
end
