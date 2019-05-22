require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:request) { create(:request, sender: user, receiver: friend) }

  it 'should be a valid request' do
    expect(request).to be_valid
  end

  it 'should not be a valid request' do
    invalid_request = build(:request, sender: user, receiver: nil)
    expect(invalid_request).not_to be_valid
  end

  it 'should not allow duplicate requests' do
    request1 = request
    request2 = build(:request, sender: request1.sender, receiver: request1.receiver)
    expect(request2).not_to be_valid
  end

  it 'should not allow inverse requests' do
    request1 = request
    request2 = build(:request, sender: request1.receiver, receiver: request1.sender)
    expect { request2.save! }.to raise_error
  end
end