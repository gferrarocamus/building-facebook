# frozen_string_literal: true

require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  test 'should not allow duplicate friendships' do
    user1 = users(:user1)
    user2 = users(:user2)
    assert_not Friendship.exists?(user_id: user1.id, friend_id: user2.id)
    assert_not Friendship.exists?(user_id: user2.id, friend_id: user1.id)
    user1.friends << user2
    assert user1.friends.count == 1
    assert user2.friends.count == 1
    assert Friendship.exists?(user_id: user1.id, friend_id: user2.id)
    assert Friendship.exists?(user_id: user2.id, friend_id: user1.id)
    user2.friendships.create(friend_id: user1.id)
    assert user1.friends.count == 1
    assert user2.friends.count == 1
  end
end
