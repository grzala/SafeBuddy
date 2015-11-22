class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :region_id
      t.text :message
      t.date :date

      t.timestamps null: false
    end
  end
end
