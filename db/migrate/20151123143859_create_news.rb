class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :paragraph
      t.date :date
      t.string :url
      t.string :src

      t.timestamps null: false
    end
  end
end
