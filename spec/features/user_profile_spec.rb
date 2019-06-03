# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User profile', type: :feature do
  before do
    @user = create(:user)
    @friend = create(:user)
    @random = create(:user)
    create(:friendship, active_friend: @user, passive_friend: @friend)
    @post = create(:post, user: @user)
  end

  scenario 'should display user data and links' do
    login_as(@user)
    visit user_path(@user)
    expect(page).to have_text(@user.name)
    expect(page).to have_text(@user.email)
    expect(page).to have_css("img[src*='secure.gravatar.com']")
    @user.posts.each do |post|
      expect(page).to have_text(post.content)
    end
    expect(page).to have_link('New Post')
    expect(page).to have_link('Edit profile')
  end

  scenario 'should see friends profile with correct elements' do
    login_as(@user)
    visit user_path(@friend)
    expect(page).to have_button('Unfriend')
  end

  scenario 'should see not friend profile with correct elements' do
    login_as(@user)
    visit user_path(@random)
    expect(page).to have_button('Send friend request')
  end
end
