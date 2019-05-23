# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users index page', type: :feature do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:receiver) { create(:user) }
  let(:friendship) { create(:friendship, user: user, friend: friend) }
  let(:request) { create(:request, sender: user, receiver: receiver) }
  before(:example) do
    login_as(user)
  end

  scenario 'lists all users' do
    visit '/users'
    expect(page).to have_text(user.name)
    expect(page).to have_text(friend.name)
    expect(page).to have_text(receiver.name)
  end

  # scenario 'shows appropriate buttons' do
  #   visit '/users'
  #   expect(page).to have_button('Cancel request')
  #   expect(page).to have_button('Unfriend')
  # end
end
