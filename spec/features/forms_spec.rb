# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Form', type: :feature do
  let(:user) { create(:user) }

  scenario 'User signs up' do
    visit '/signup'

    fill_in 'Name', with: 'User'
    fill_in 'Email', with: 'example999@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'

    expect(page).to have_text('Welcome! You have signed up successfully.')
  end

  scenario 'User fails signup with empty name' do
    visit '/signup'

    fill_in 'Name', with: ''
    fill_in 'Email', with: 'example999@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'

    expect(page).to have_text("Name can't be blank")
  end

  scenario 'User logs in successfully' do
    visit '/login'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_text('Signed in successfully.')
  end

  scenario 'User fails login with empty password' do
    visit '/login'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: ''
    click_button 'Log in'

    expect(page).to have_text('Invalid Email or password.')
  end

  describe 'Signed in user' do
    let(:post) { create(:post, user: user) }

    before(:example) do
      login_as(user)
    end

    scenario 'successfully makes a new post' do
      visit '/posts/new'

      fill_in 'Content', with: 'New post'
      click_button 'Post'

      expect(page).to have_text('Post created successfully.')
    end

    scenario 'fails making a new post without content' do
      visit '/posts/new'

      fill_in 'Content', with: ''
      click_button 'Post'

      expect(page).to have_text('Content should not be empty.')
    end

    scenario 'User successfully makes a new comment' do
      visit '/posts'

      fill_in 'Content', with: 'New comment'
      click_button 'Comment'

      expect(page).to have_text('New comment')
    end
  end
end
