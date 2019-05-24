# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Post creation', type: :feature do
  before do
    @user = create(:user)
  end

  scenario 'should work' do
    login_as(@user)
    visit root_path
    click_link('New Post')
    expect(page).to have_current_path(new_post_path)
    fill_in 'Content', with: 'Some text'
    click_button 'Post'
    expect(page).to have_text('Post created successfully.')
    # save_and_open_page
  end
end