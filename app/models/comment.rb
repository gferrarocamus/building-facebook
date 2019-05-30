# frozen_string_literal: true

# Comment Model
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  scope :date_sorted, -> { order(created_at: :asc) }
end
