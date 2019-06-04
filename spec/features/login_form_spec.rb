# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Login', type: :feature do
  let(:user) { create(:user) }

  scenario 'when filling form with correct credentials' do
    visit '/login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')
  end

  scenario 'unsuccessful when filling form with empty password' do
    visit '/login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: ''
    click_button 'Log in'
    expect(page).to have_text('Invalid Email or password.')
  end

  scenario 'should take user back to login page after logout' do
    login_as(user)
    visit '/'
    click_link 'Logout'
    expect(page).to have_current_path(new_user_session_path)
  end
end
