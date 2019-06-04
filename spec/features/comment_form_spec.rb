# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Login form', type: :feature do
  let(:user) { create(:user) }

  describe 'for commenting on a post' do
    before(:example) do
      login_as(user)
      @friend = create(:user)
      @friendship = create(:friendship, active_friend: user, passive_friend: @friend)
      @post = create(:post, user: @friend)
    end

    scenario 'successfully' do
      visit user_path(@friend)
      fill_in 'comment_content', with: 'New comment'
      click_button 'Comment'
      expect(page).to have_text('New comment')
    end

    scenario 'unsuccessfully without content' do
      visit user_path(@friend)
      fill_in 'comment_content', with: ''
      click_button 'Comment'
      expect(page).not_to have_text('Could not publish comment.')
    end
  end
end
