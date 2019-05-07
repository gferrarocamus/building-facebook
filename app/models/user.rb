# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, class_name: 'User'

  has_many :sent_requests, class_name: 'Request', foreign_key: 'sender_id', inverse_of: :receiver
  has_many :received_requests, class_name: 'Request', foreign_key: 'receiver_id', inverse_of: :sender
  has_many :senders, through: :received_requests, source: :sender
  has_many :receivers, through: :sent_requests, source: :receiver

  has_many :posts
  has_many :comments
  has_many :likes

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
