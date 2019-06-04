# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Friending users', type: :feature do
  before do
    @user = create(:user)
    @friend = create(:user)
    @sender = create(:user)
    @receiver = create(:user)
    @request = create(:request, sender: @sender, receiver: @user)
  end

  scenario 'should work' do
    login_as(@user)
    visit user_path(@friend)
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

  scenario 'should not be possible without a valid request' do
    login_as(@user)
    visit requests_path
    expect(page).to have_button('Accept request')
    @request.destroy
    click_button 'Accept request'
    expect(page).to have_text('No request found')
  end

  scenario 'should not be able to sent request if there already is one' do
    login_as(@sender)
    visit user_path(@receiver)
    expect(page).to have_button('Send friend request')
    create(:request, sender: @receiver, receiver: @sender)
    click_button 'Send friend request'
    expect(page).to have_text('Could not send request')
    expect(page).to have_button('Accept request')
    expect(page).to have_button('Reject request')
  end
end
