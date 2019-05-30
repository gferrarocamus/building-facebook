# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:friendship) { create(:friendship, active_friend: user, passive_friend: friend) }

  it 'should be a valid friendship' do
    expect(friendship).to be_valid
  end

  it 'should not be a valid friendship' do
    invalid_friendship = build(:friendship,
                               active_friend: friendship.passive_friend,
                               passive_friend: friendship.active_friend)
    expect(invalid_friendship).not_to be_valid
  end

  it 'should not allow duplicate friendships' do
    friendship1 = friendship
    friendship2 = build(
      :friendship,
      active_friend: friendship1.active_friend,
      passive_friend: friendship1.passive_friend
    )
    expect(friendship2).not_to be_valid
  end

  it '#destroy should delete friendship' do
    friendship1 = friendship
    count = Friendship.count
    friendship1.destroy
    expect(Friendship.count).to eq(count - 1)
  end
end
