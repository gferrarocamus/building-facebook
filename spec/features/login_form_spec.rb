# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Login form', type: :feature do
  let(:user) { create(:user) }
  
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

end