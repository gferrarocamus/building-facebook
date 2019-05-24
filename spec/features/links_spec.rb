# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Links', type: :feature do
  before do
    @user = create(:user)
    @friend = create(:user)
    @friendship = create(:friendship, active_friend: @user, passive_friend: @friend)
    @post = create(:post, user: @friend)
  end

  scenario 'in header for signed in users' do
    visit '/'
    expect(page).to have_link('Social network')
  end

  scenario 'in header for users not signed in' do
    login_as(@user)
    visit '/'
    expect(page).to have_link('Social network')
    expect(page).to have_link(@user.name)
    expect(page).to have_link('Find friends')
    expect(page).to have_link('Notifications (0)')
    expect(page).to have_link('Logout')
  end

  scenario 'in user profile for new post' do
    login_as(@user)
    visit '/posts'
    expect(page).to have_link('New Post')
  end

  scenario 'in feed for liking and commenting on posts' do
    login_as(@user)
    visit user_path(@friend)
    expect(page).to have_button('Comment')
    expect(page).to have_link('Like')
  end
end

