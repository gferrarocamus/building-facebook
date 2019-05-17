require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validation' do
    it 'should require a name' do
      user.name = ''
      user.valid?
      expect(user.errors.messages.keys).to include(:name)
    end

    it 'should require an email' do
      user.email = ''
      user.valid?
      expect(user.errors.messages.keys).to include(:email)
    end

    it 'should reject invalid addresses' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        user.valid?
        expect(user.errors[:email]).to include('is invalid')
      end
    end

    it 'should reject duplicate email' do
      duplicate_user = user.dup
      expect(duplicate_user.valid?).to be false
    end

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
      user.valid?
      expect(user.email).to eq('example@email.com')
    end
  end

  describe 'associations' do
    it 'should also destroy posts when user destroyed' do
      user.save
      user.posts.create(content: "MyPost")
      count = Post.all.count
      user.destroy
      expect(Post.all.count).to eq(count - 1)
    end
  end
end
