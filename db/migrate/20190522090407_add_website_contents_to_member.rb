class AddWebsiteContentsToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :website_contents, :jsonb, default: {}
  end
end
