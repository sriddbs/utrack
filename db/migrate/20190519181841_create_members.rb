class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :name, null: false, index: true
      t.string :website_url, null: false
      t.string :url_key, null: false, index: true
      t.timestamps
    end
  end
end
