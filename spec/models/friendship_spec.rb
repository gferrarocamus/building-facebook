require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }

  it 'should be a valid friendship' do
    friendship = user.friendships.create(friend_id: friend.id)
    expect(friendship).to be_valid
  end

  it 'should not be a valid friendship' do
    friendship = user.friendships.create(friend_id: nil)
    expect(friendship).not_to be_valid
  end

  it 'should not allow duplicate friendships' do
    expect(Friendship.exists?(user_id: user.id, friend_id: friend.id)).to be false
    expect(Friendship.exists?(user_id: friend.id, friend_id: user.id)).to be false
    user.friends << friend
    expect(user.friends.count).to eq(1)
    expect(friend.friends.count).to eq(1)
    expect(Friendship.exists?(user_id: user.id, friend_id: friend.id)).to be true
    expect(Friendship.exists?(user_id: friend.id, friend_id: user.id)).to be true
    friend.friendships.create(friend_id: user.id)
    expect(user.friends.count).to eq(1)
    expect(friend.friends.count).to eq(1)
  end

  it '#destroy should delete mirror friendship' do
    friendship = user.friendships.create(friend_id: friend.id)
    count = Friendship.count
    friendship.destroy
    expect(Friendship.count).to eq(count - 2)
  end
end
