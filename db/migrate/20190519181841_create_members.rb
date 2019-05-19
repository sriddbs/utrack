class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :name, null: false
      t.string :website_short_url, null: false
      t.string :website_url, null: false
      t.timestamps
    end
  end
end
