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
end
