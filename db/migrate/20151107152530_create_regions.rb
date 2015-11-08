class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name

      t.timestamps null: false
    end
	
	regions = {
		"Aberdeen City" => 1,
		"Aberdeenshire" => 2,
		"Angus" => 3,
		"Argyll & Bute" => 4,
		"Clackmannanshire" => 5,
		"Dumfries & Galloway" => 6,
		"Dundee City" => 7,
		"East Ayshire" => 8,
		"East Dunbartonshire" => 9,
		"East Lothian" => 10,
		"East Renfrewshire" => 11,
		"City Of Edinburgh" => 12,
		"Eilean Siar" => 13,
		"Falkirk" => 14,
		"Fife" => 15,
		"Glasgow City" => 16,
		"Highland" => 17,
		"Inverclyde" => 18,
		"Midlothian" => 19,
		"Moray" => 20,
		"North Ayrshire" => 21,
		"North Lanarkshire" => 22,
		"Orkney Islands" => 23,
		"Perth & Kinross" => 24,
		"Renfrewshire" => 25,
		"Scottish Borders" => 26,
		"Shetland Islands" => 27,
		"South Ayrshire" => 28,
		"South Lanarkshire" => 29,
		"Stirling" => 30,
		"West Dunbartonshire" => 31,
		"West Lothian" => 32
	}
	
	regions.each do |key, value|
		region = Region.new
		region.id = value
		region.name = key
		region.save
	end
  end
end
