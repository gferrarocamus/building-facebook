# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:author) { create(:user) }
  let(:post) { create(:post, user: author) }
  let(:like) { create(:like, post: post, user: user) }

  it 'should be valid' do
    expect(like).to be_valid
  end

  it 'should not allow duplicate likes' do
    like1 = like
    like2 = build(:like, user: like1.user, post: like1.post)
    expect(like2).not_to be_valid
  end
end
