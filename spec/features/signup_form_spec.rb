# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Signup form', type: :feature do
  let(:user) { create(:user) }

  scenario 'with correct data' do
    visit '/signup'
    fill_in 'Name', with: 'User'
    fill_in 'Email', with: 'example999@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'
    expect(page).to have_text('Welcome! You have signed up successfully.')
  end

  scenario 'with empty name' do
    visit '/signup'
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'example999@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'
    expect(page).to have_text("Name can't be blank")
  end
end
