class CreateLastUpdateds < ActiveRecord::Migration
  def change
    create_table :last_updateds do |t|
      t.datetime :time

      t.timestamps null: false
    end
  end
end
