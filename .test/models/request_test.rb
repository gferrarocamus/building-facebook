# frozen_string_literal: true

require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  test 'should be a valid request' do
    sender = users(:user1)
    receiver = users(:user2)
    request = sender.sent_requests.create(receiver_id: receiver.id)
    assert request.valid?
  end

  test 'should not be a valid request' do
    sender = receiver = users(:user1)
    sender.receivers << receiver
    request = sender.sent_requests.create(receiver_id: receiver.id)
    assert_not request.valid?
  end

  test 'should not allow duplicate/inverse requests' do
    user1 = users(:user1)
    user2 = users(:user2)
    assert_not Request.exists?(sender_id: user1.id, receiver_id: user2.id)
    assert_not Request.exists?(sender_id: user2.id, receiver_id: user1.id)
    user1.sent_requests.create(receiver_id: user2.id)
    assert Request.exists?(sender_id: user1.id, receiver_id: user2.id)
    user2.sent_requests.create(receiver_id: user1.id)
    assert_not Request.exists?(sender_id: user2.id, receiver_id: user1.id)
  end
end
