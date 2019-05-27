# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Friending users', type: :feature do
  before do
    @user = create(:user)
    @friend = create(:user)
    # @friendship = create(:friendship, active_friend: @user, passive_friend: @friend)
    # @post = create(:post, user: @friend)
  end

  scenario 'should work' do
    login_as(@user)
    visit users_path
    click_button 'Send friend request'
    expect(page).to have_button('Cancel request')
    logout(@user)
    login_as(@friend)
    visit root_path
    expect(page).to have_text('Notifications (1)')
    visit requests_path
    click_button 'Accept request'
    expect(page).not_to have_button('Accept request')
    expect(page).to have_text('Notifications (0)')
    visit user_path(@user)
    expect(page).to have_button('Unfriend')
    click_button 'Unfriend'
    expect(page).to have_button('Send friend request')
  end
end
