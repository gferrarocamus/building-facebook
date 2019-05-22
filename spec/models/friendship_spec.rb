require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:friendship) { create(:friendship, user: user, friend: friend) }

  it 'should be a valid friendship' do
    expect(friendship).to be_valid
  end

  it 'should not be a valid friendship' do
    invalid_friendship = build(:friendship, user: user, friend: nil)
    expect(invalid_friendship).not_to be_valid
  end

  it 'should not allow duplicate friendships' do
    friendship1 = friendship
    friendship2 = build(:friendship, user: friendship1.user, friend: friendship1.friend)
    expect(friendship2).not_to be_valid
  end

  it '#destroy should delete mirror friendship' do
    friendship1 = friendship
    count = Friendship.count
    friendship1.destroy
    expect(Friendship.count).to eq(count - 2)
  end
end
