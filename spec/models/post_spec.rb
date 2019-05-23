# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  it 'should be valid' do
    expect(post).to be_valid
  end

  describe 'content validation' do
    it 'should require content text' do
      post.content = ''
      post.valid?
      expect(post.errors.messages.keys).to include(:content)
    end
  end

  it 'should allow comments' do
    comment = post.comments.build(content: 'My coment', user_id: user.id)
    expect(comment).to be_valid
    comment.save
    expect { post.destroy }.to \
      change(Comment, :count)
      .by(-1)
  end

  it 'should allow likes' do
    like = post.likes.build(user_id: user.id)
    expect(like).to be_valid
    like.save
    expect { post.destroy }.to \
      change(Like, :count)
      .by(-1)
  end
end
