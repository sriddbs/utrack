class AddFriendshipsCountToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :friendships_count, :integer, default: 0
  end
end
