# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Login form', type: :feature do
  let(:user) { create(:user) }

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
end
