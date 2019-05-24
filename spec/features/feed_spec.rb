# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Post index page/feed', type: :feature do
  before(:example) do
    @user = create(:user)
    login_as(@user)
    @friend = create(:user)
    @random = create(:user)
    create(:friendship, active_friend: @user, passive_friend: @friend)
    create(:friendship, active_friend: @friend, passive_friend: @random)
    @own_post = create(:post, user: @user)
    @friend_post = create(:post, user: @friend)
    @random_post = create(:post, user: @random)
    @friend_comment = create(:comment, post: @friend_post, user: @friend)
    @random_comment = create(:comment, post: @friend_post, user: @random)
    create(:like, post: @friend_post, user: @random)
    create(:like, post: @friend_post, user: @user)
  end

  it 'should display posts by self and friends and comments/likes on them' do
    visit root_url
    expect(page).to have_text(@own_post.content)
    expect(page).to have_text(@friend_post.content)
    expect(page).not_to have_text(@random_post.content)
    expect(page).to have_text(@friend_comment.content)
    expect(page).to have_text(@random_comment.content)
    expect(page).to have_text('2 likes')
    expect(page).to have_text('0 likes')
  end
end
