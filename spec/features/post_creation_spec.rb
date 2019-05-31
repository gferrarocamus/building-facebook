# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Post creation', type: :feature do
  before do
    @user = create(:user)
    login_as(@user)
  end

  scenario 'successful with correct data' do
    visit new_post_path
    fill_in 'Content', with: 'New post'
    click_button 'Post'
    expect(page).to have_text('Post created successfully.')
  end

  scenario 'unsuccessful without content' do
    visit new_post_path
    fill_in 'Content', with: ''
    click_button 'Post'
    expect(page).to have_text('Content should not be empty.')
  end
end
