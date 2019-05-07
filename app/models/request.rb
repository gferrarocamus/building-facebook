class Request < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  before_create :check_inverse

  private

  def check_inverse
    if Request.find_by(sender_id: receiver.id, receiver_id: sender.id)
      self.sender, self.receiver = self.receiver, self.sender
    end
  end
end
