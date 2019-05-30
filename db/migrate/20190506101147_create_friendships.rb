# frozen_string_literal: true

# CreateFriendships Migration
class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :active_friend
      t.references :passive_friend

      t.timestamps
    end

    add_foreign_key :friendships, :users, column: :active_friend_id
    add_foreign_key :friendships, :users, column: :passive_friend_id
    add_index :friendships, %i[active_friend_id passive_friend_id], unique: true
  end
end
