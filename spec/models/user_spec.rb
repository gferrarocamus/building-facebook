# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validations' do
    context 'with complete user details' do
      it 'is valid' do
        expect(user).to be_valid
      end
    end

    context 'with no name' do
      it 'is invalid' do
        user.name = ''
        user.valid?
        expect(user.errors.messages.keys).to include(:name)
      end
    end
  end

  describe '#destroy in associations' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }

    it 'should also destroy posts' do
      post = user.posts.create(content: 'MyPost')
      user.destroy
      expect(Post.all).not_to include(post)
    end

    it 'should also destroy requests' do
      request = user.sent_requests.create(receiver_id: friend.id)
      user.destroy
      expect(Request.all).not_to include(request)
    end

    it 'should also destroy friendships' do
      friendship = user.active_friendships.create(passive_friend_id: friend.id)
      user.destroy
      expect(Friendship.all).not_to include(friendship)
    end
  end

  describe 'associations' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }
    let(:new_friend) { create(:user) }
    let(:new_user) { create(:user) }

    it 'should allow sending requests' do
      expect(user.receivers).not_to include(friend)
      expect(friend.senders).not_to include(user)
      r = user.sent_requests.create(receiver_id: friend.id)
      expect(user.sent_requests).to include(r)
      expect(friend.received_requests).to include(r)
      # expect(user.receivers).to include(friend)
      # expect(friend.senders).to include(user)
    end

    it 'should allow adding friends' do
      expect(user.friends).not_to include(friend)
      expect(friend.friends).not_to include(user)
      f = user.active_friendships.create(passive_friend_id: friend.id)
      expect(user.friendships).to include(f)
      # expect(user.friends).to include(friend)
      # expect(friend.friends).to include(user)
    end
  end
end
