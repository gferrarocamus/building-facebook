# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Profile edit form', type: :feature do
  before do
    @user = create(:user)
    login_as(@user)
  end

  scenario 'with correct data' do
    visit edit_user_registration_path
    fill_in 'Name', with: 'New Name'
    fill_in 'Current password', with: @user.password
    click_button 'Update'
    expect(page).to have_text('Your account has been updated successfully.')
    @user.reload
    expect(@user.name).to eq('New Name')
  end

  scenario 'without current password' do
    visit edit_user_registration_path
    old_name = @user.name
    fill_in 'Name', with: 'New Name'
    click_button 'Update'
    expect(page).to have_text("Current password can't be blank")
    @user.reload
    expect(@user.name).to eq(old_name)
  end
end
