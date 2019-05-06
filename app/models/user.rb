# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  has_many :friends, through: :friendships, class_name: 'User'
  # has_many :befriended_users, through: :friendships, class_name: 'User'
  has_many :friendships, class_name: 'Friendship', foreign_key: :user_id, dependent: :destroy
  has_many :friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
end
