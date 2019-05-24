# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Post creation', type: :feature do
  before do
    @user = create(:user)
    @friend = create(:user)
    @friendship = create(:friendship, active_friend: @user, passive_friend: @friend)
    @post = create(:post, user: @friend)
  end

  scenario 'should work' do
    login_as(@user)
    visit root_path
    click_link('New Post')
    expect(page).to have_current_path(new_post_path)
    fill_in 'Content', with: 'Some text'
    click_button 'Post'
    expect(page).to have_text('Post created successfully.')
    save_and_open_page
  end
end

# TO DO
# Post creation
# Friendships/requests
# Comment creation