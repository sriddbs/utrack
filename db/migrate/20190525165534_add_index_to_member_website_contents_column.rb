class AddIndexToMemberWebsiteContentsColumn < ActiveRecord::Migration[5.2]
  def change
    add_index :members, :website_contents, using: :gin
  end
end
