# frozen_string_literal: true

# Like Model
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
