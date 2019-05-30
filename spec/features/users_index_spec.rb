# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users index page', type: :feature do
  before(:example) do
    @user = create(:user)
    login_as(@user)
    @friend = create(:user)
    @sender = create(:user)
    @random = create(:user)
    @receiver = create(:user)
    create(:friendship, active_friend: @user, passive_friend: @friend)
    create(:request, sender: @user, receiver: @receiver)
    create(:request, sender: @sender, receiver: @user)
  end

  it 'lists all users' do
    visit '/users'
    expect(page).to have_text(@user.name)
    expect(page).to have_text(@friend.name)
    expect(page).to have_text(@random.name)
    expect(page).to have_text(@receiver.name)
  end

  it 'shows appropriate buttons' do
    visit '/users'
    expect(page).to have_button('Send friend request')
    expect(page).to have_button('Accept request')
    expect(page).to have_button('Reject request')
    expect(page).to have_button('Cancel request')
    expect(page).to have_button('Unfriend')
  end
end
