class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :member, foreign_key: true, index: true
      t.references :friend, index: true, foreign_key: { to_table: :members }
      t.timestamps
    end
  end
end
