# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, class_name: 'User'

  has_many :sent_requests, class_name: 'Request', foreign_key: 'sender_id', inverse_of: :receiver
  has_many :received_requests, class_name: 'Request', foreign_key: 'receiver_id', inverse_of: :sender
  has_many :senders, through: :received_requests, source: :sender
  has_many :receivers, through: :sent_requests, source: :receiver

  has_many :posts
  has_many :comments
  has_many :likes
end
