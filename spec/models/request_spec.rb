require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }

  it 'should be a valid request' do
    request = user.sent_requests.create(receiver_id: friend.id)
    expect(request).to be_valid
  end

  it 'should not be a valid request' do
    request = user.sent_requests.create(receiver_id: nil)
    expect(request).not_to be_valid
  end

  it 'should not allow duplicate requests' do
    expect(Request.exists?(sender_id: user.id, receiver_id: friend.id)).to be false
    expect(Request.exists?(sender_id: friend.id, receiver_id: user.id)).to be false
    user.sent_requests.create(receiver_id: friend.id)
    expect(Request.exists?(sender_id: user.id, receiver_id: friend.id)).to be true
    duplicate = Request.create(sender_id: user.id, receiver_id: friend.id)
    expect(duplicate).not_to be_valid
  end

  it 'should not allow inverse requests' do
    expect(Request.exists?(sender_id: user.id, receiver_id: friend.id)).to be false
    expect(Request.exists?(sender_id: friend.id, receiver_id: user.id)).to be false
    user.sent_requests.create(receiver_id: friend.id)
    expect(Request.exists?(sender_id: user.id, receiver_id: friend.id)).to be true
    inverse = Request.new(sender_id: friend.id, receiver_id: user.id)
    expect{ inverse.save! }.to raise_error
  end
end
