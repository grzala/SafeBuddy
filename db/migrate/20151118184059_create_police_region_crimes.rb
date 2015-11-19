class CreatePoliceRegionCrimes < ActiveRecord::Migration
  def change
    create_table :police_region_crimes do |t|
      t.integer :category_id
      t.integer :number
      t.integer :police_region_id
      t.integer :year

      t.timestamps null: false
    end
  end
end
