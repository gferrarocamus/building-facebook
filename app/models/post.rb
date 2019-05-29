# frozen_string_literal: true

# Post Model
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :content, presence: true

  scope :date_sorted, -> { order(created_at: :desc) }

  scope :with_associations,
        lambda {
          includes(
            :user,
            :likes,
            comments: [:user]
          )
        }
end
