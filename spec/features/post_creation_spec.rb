# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Post creation', type: :feature do
  before do
    @user = create(:user)
    login_as(@user)
  end

  scenario 'filling a new post form' do
    visit new_post_path
    fill_in 'Content', with: 'Some text'
    click_button 'Post'
    expect(page).to have_text('Post created successfully.')
  end
end
