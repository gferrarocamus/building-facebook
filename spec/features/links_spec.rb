# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Links', type: :feature do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:friendship) { create(:friendship, user: user, friend: friend) }
  let(:post) { create(:post, user: friend) }

  scenario 'in header for signed in users' do
    visit '/'
    expect(page).to have_link('Social network')
  end

  scenario 'in header for users not signed in' do
    login_as(user)
    visit '/'
    expect(page).to have_link('Social network')
    expect(page).to have_link(user.name)
    expect(page).to have_link('Find friends')
    expect(page).to have_link('Notifications (0)')
    expect(page).to have_link('Logout')
  end

  scenario 'in user profile for new post' do
    login_as(user)
    visit '/posts'
    expect(page).to have_link('New Post')
  end

  # scenario 'in feed for liking and commenting on posts' do
  #   login_as(user)
  #   visit "/users/#{friend.id}"
  #   expect(page).to have_button('Comment')
  #   expect(page).to have_link('Like')
  # end
end

# TO DO
# Post creation
# Friendships/requests
# Comment creation
