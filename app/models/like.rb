# frozen_string_literal: true

# Like Model
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  # scope :likes_count, -> { all.group(:post_id).count }
end
