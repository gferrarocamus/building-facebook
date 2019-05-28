# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Form', type: :feature do
  let(:user) { create(:user) }

  scenario 'for signing up with correct data' do
    visit '/signup'
    fill_in 'Name', with: 'User'
    fill_in 'Email', with: 'example999@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'
    expect(page).to have_text('Welcome! You have signed up successfully.')
  end

  scenario 'for signing up with empty name' do
    visit '/signup'
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'example999@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'
    expect(page).to have_text("Name can't be blank")
  end

  scenario 'for logging in with correct credentials' do
    visit '/login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')
  end

  scenario 'for logging in with empty password' do
    visit '/login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: ''
    click_button 'Log in'

    expect(page).to have_text('Invalid Email or password.')
  end

  describe 'for making a new post' do
    before(:example) do
      login_as(user)
    end

    scenario 'successfully' do
      visit '/posts/new'
      fill_in 'Content', with: 'New post'
      click_button 'Post'
      expect(page).to have_text('Post created successfully.')
    end

    scenario 'unsuccessfully without content' do
      visit '/posts/new'
      fill_in 'Content', with: ''
      click_button 'Post'
      expect(page).to have_text('Content should not be empty.')
    end
  end

  describe 'for commenting on a post' do
    before(:example) do
      login_as(user)
      @friend = create(:user)
      @friendship = create(:friendship, active_friend: user, passive_friend: @friend)
      @post = create(:post, user: @friend)
    end

    scenario 'successfully' do
      visit user_path(@friend)
      fill_in 'comment_content', with: 'New comment'
      click_button 'Comment'
      expect(page).to have_text('New comment')
    end

    scenario 'unsuccessfully without content' do
      visit user_path(@friend)
      fill_in 'comment_content', with: ''
      click_button 'Comment'
      expect(page).not_to have_text('Could not publish comment.')
    end
  end
end
