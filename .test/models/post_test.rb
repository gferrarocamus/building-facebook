# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:user1)
    @post = @user.posts.build(content: 'Lorem ipsum dolor ...')
  end

  test 'should be valid' do
    assert @post.valid?
  end

  test 'post content should be present' do
    @post.content = ''
    assert_not @post.valid?
  end
end
