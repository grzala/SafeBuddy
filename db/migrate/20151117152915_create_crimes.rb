class CreateCrimes < ActiveRecord::Migration
  def change
    create_table :crimes do |t|
      t.integer :group_id
      t.integer :year
      t.integer :number
      t.integer :region_id

      t.timestamps null: false
    end
  end
end
