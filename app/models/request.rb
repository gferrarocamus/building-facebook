# frozen_string_literal: true

# Request Model
class Request < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  
  validates :sender_id, uniqueness: { scope: :receiver_id }

  before_create :check_inverse

  private

  def check_inverse
    return unless Request.exists?(sender_id: receiver.id, receiver_id: sender.id)

    self.sender, self.receiver = receiver, sender
  end
end
