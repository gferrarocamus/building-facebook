# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, class_name: 'User'
end
