class CreatePoliceRegions < ActiveRecord::Migration
  def change
    create_table :police_regions do |t|
	  t.string :name
	  
      t.timestamps null: false
    end
	
	areas = {
		"Central" => 1,
		"Northern" => 2,
		"Grampian" => 3,
		"Tayside" => 4,
		"Fife" => 5,
		"Lothian & Borders" => 6,
		"Strathclyde" => 7,
		"Dumfries & Galloway" => 8
	}
	
	areas.each do |key, value|
		region = PoliceRegion.new
		region.id = value
		region.name = key
		region.save
	end
  end
end
