# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Post index page/feed', type: :feature do
  before(:example) do
    @user = create(:user)
    @friend = create(:user)
    @random = create(:user)
    create(:friendship, active_friend: @user, passive_friend: @friend)
    create(:friendship, active_friend: @friend, passive_friend: @random)
    @user_post = create(:post, user: @user)
    @friend_post = create(:post, user: @friend)
    @feed_posts = @user.posts + @friend.posts
    @random_post = create(:post, user: @random)
    @friend_comment = create(:comment, post: @user_post, user: @friend)
    @random_comment = create(:comment, post: @friend_post, user: @random)
    create(:like, post: @friend_post, user: @random)
    create(:like, post: @friend_post, user: @user)
  end

  scenario 'should take user back to login page if not logged in' do
    visit '/posts'
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'should take user to feed if logged in' do
    login_as(@user)
    visit '/posts'
    expect(page).to have_current_path(posts_path)
  end

  scenario 'should display links for liking and commenting on posts' do
    login_as(@user)
    visit user_path(@friend)
    expect(page).to have_button('Comment')
    expect(page).to have_link('Unlike')
  end

  it 'should display posts by self and friends and comments/likes on them' do
    login_as(@user)
    visit root_url
    @feed_posts.each do |post|
      expect(page).to have_text(post.content)
      expect(page).to have_text(post.user.name)
      post.comments.each do |comment|
        expect(page).to have_text(comment.content)
      end
      if post.likes.count == 1
        (expect(page).to have_text('1 like'))
      else
        (expect(page).to have_text("#{post.likes.count} likes"))
      end
    end
    expect(page).not_to have_text(@random_post.content)
  end
end
