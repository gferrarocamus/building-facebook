# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:author) { create(:user) }
  let(:post) { create(:post, user: author) }
  let(:comment) { create(:comment, post: post, user: user) }

  it 'should be valid' do
    expect(comment).to be_valid
  end

  describe 'content validation' do
    it 'should require content text' do
      comment.content = ''
      comment.valid?
      expect(comment.errors.messages.keys).to include(:content)
    end
  end
end
