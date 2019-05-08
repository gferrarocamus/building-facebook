# frozen_string_literal: true

# Request Model
class Request < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  validates :sender_id, uniqueness: { scope: :receiver_id }

  before_create :check_inverse

  private

  def check_inverse
    self.sender, self.receiver = receiver, sender if Request.find_by(sender_id: receiver.id, receiver_id: sender.id)
  end
end
