# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Links', type: :feature do
  before do
    @user = create(:user)
    @friend = create(:user)
    create(:friendship, active_friend: @user, passive_friend: @friend)
    create(:post, user: @friend)
  end

  scenario 'are displayed in header for users not signed' do
    visit root_path
    expect(page).to have_link('Social network')
    expect(page).not_to have_link('Logout')
  end

  scenario 'are displayed in header for users signed in' do
    login_as(@user)
    visit root_path
    expect(page).to have_link('Social network')
    expect(page).to have_link(@user.name)
    expect(page).to have_link('Find friends')
    expect(page).to have_link('Notifications (0)')
    expect(page).to have_link('Logout')
  end

  scenario 'are displayed in user profile for new post' do
    login_as(@user)
    visit '/posts'
    expect(page).to have_link('New Post')
  end

  scenario 'are displayed in feed for liking and commenting on posts' do
    login_as(@user)
    visit user_path(@friend)
    expect(page).to have_button('Comment')
    expect(page).to have_link('Like')
  end

  scenario 'allow liking/unliking posts' do
    login_as(@user)
    visit root_path
    click_link 'Like'
    expect(page).to have_text('1 like')
    expect(page).not_to have_button('Like')
    click_link 'Unlike'
    expect(page).to have_text('0 likes')
  end
end
