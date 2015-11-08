class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :hash_password
      t.string :salt
      t.boolean :moderator

      t.timestamps null: false
    end
  end
end
