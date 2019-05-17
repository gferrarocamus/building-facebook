require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  it 'should be valid' do
    expect(user).to be_valid
  end

  describe 'name validation' do
    it 'should require a name' do
      user.name = ''
      user.valid?
      expect(user.errors.messages.keys).to include(:name)
    end
  end

  describe 'email validations' do
    it 'should require an email' do
      user.email = ''
      user.valid?
      expect(user.errors.messages.keys).to include(:email)
    end

    it 'should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                            first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end

    it 'should reject invalid addresses' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        user.valid?
        expect(user.errors[:email]).to include('is invalid')
      end
    end

    it 'should reject duplicate emails' do
      user.save
      duplicate_user = user.dup
      expect(duplicate_user.valid?).to be false
    end
  end

  describe 'password validations' do
    it 'should require a password' do
      user.password = ''
      user.valid?
      expect(user.errors.messages.keys).to include(:password)
    end

    it 'should require a password with minumum length of 6 characters' do
      user.password = '12345'
      user.valid?
      expect(user.errors.messages.keys).to include(:password)
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end

  describe '#email_downcase' do
    it 'should save email as lowercase' do 
      user.email = "EXAMPLE@EMAIL.COM"
      user.save
      expect("EXAMPLE@EMAIL.COM".downcase).to eq(user.reload.email)
    end
  end

  describe 'associations' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }

    it 'should also destroy posts when user is destroyed' do
      user.posts.create(content: "MyPost")
      count = Post.all.count
      user.destroy
      expect(Post.all.count).to eq(count - 1)
    end

    it 'should also destroy requests when user is destroyed' do
      user.sent_requests.create(receiver_id: friend.id)
      count = Request.all.count
      user.destroy
      expect(Request.all.count).to eq(count - 1)
    end

    it 'should also destroy friendships when user is destroyed' do
      user.friendships.create(friend_id: friend.id)
      count = Friendship.all.count
      user.destroy
      expect(Friendship.all.count).to eq(count - 2) #deletes mirrored friendship also
    end

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
      f = user.friendships.create(friend_id: friend.id)
      expect(user.friendships).to include(f)
      # expect(user.friends).to include(friend)
      # expect(friend.friends).to include(user)
    end
  end
end
