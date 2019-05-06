# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :sender
      t.references :receiver

      t.timestamps
    end
    add_foreign_key :requests, :users, column: :sender_id
    add_foreign_key :requests, :users, column: :receiver_id
  end
end
