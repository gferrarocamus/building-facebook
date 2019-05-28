# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :active_friendships, dependent: :destroy,
                                class_name: 'Friendship',
                                foreign_key: 'active_friend_id',
                                inverse_of: :active_friend
  has_many :passive_friendships, dependent: :destroy,
                                 class_name: 'Friendship',
                                 foreign_key: 'passive_friend_id',
                                 inverse_of: :passive_friend
  has_many :active_friends, through: :passive_friendships
  has_many :passive_friends, through: :active_friendships

  has_many :sent_requests, class_name: 'Request',
                           foreign_key: 'sender_id',
                           inverse_of: :sender,
                           dependent: :destroy
  has_many :received_requests, class_name: 'Request',
                               foreign_key: 'receiver_id',
                               inverse_of: :receiver,
                               dependent: :destroy
  has_many :senders, through: :received_requests
  has_many :receivers, through: :sent_requests

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }

  def feed_ids
    active_friends.pluck('active_friend_id') + passive_friends.pluck('passive_friend_id') << id
  end

  def friendships
    active_friendships + passive_friendships
  end

  def friends
    active_friends + passive_friends
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data']) && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end
