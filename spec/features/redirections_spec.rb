# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Redirections', type: :feature do
  let(:user) { create(:user) }

  scenario 'take user back to login page if not logged in' do
    visit '/posts'
    expect(page).to have_current_path(new_user_session_path)    
  end

  scenario 'take user to requested page if logged in' do
    login_as(user)
    visit '/posts'
    expect(page).to have_current_path(posts_path)    
  end

  scenario 'take user back to login page after logout' do
    login_as(user)
    visit '/'
    click_link 'Logout'
    expect(page).to have_current_path(new_user_session_path)    
  end  
end