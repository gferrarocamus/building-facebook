# frozen_string_literal: true

require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  test 'should be a valid friendship' do
    user = users(:user1)
    friend = users(:user2)
    friendship = user.friendships.create(friend_id: friend.id)
    assert friendship.valid?
  end

  test 'should not be a valid friendship' do
    user = friend = users(:user1)
    user.friends << friend
    friendship = friend.friendships.create(friend_id: user.id)
    assert_not friendship.valid?
  end

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

  test 'should delete mirror friendship' do
    user = users(:user1)
    friend = users(:user2)
    friendship = user.friendships.create(friend_id: friend.id)
    assert_difference 'Friendship.count', -2 do
      friendship.destroy
    end
  end
end
