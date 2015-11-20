class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
	  t.integer :police_region_id

      t.timestamps null: false
    end
	
	regions = {
		"Aberdeen City" => [1, "Grampian"],
		"Aberdeenshire" => [2, "Grampian"],
		"Angus" => [3, "Tayside"],
		"Argyll & Bute" => [4, "Strathclyde"],
		"Clackmannanshire" => [5, "Central"],
		"Dumfries & Galloway" => [6, "Dumfries & Galloway"],
		"Dundee City" => [7, "Tayside"],
		"East Ayrshire" => [8, "Strathclyde"],
		"East Dunbartonshire" => [9, "Strathclyde"],
		"East Lothian" => [10, "Lothian & Borders"],
		"East Renfrewshire" => [11, "Strathclyde"],
		"City Of Edinburgh" => [12, "Lothian & Borders"],
		"Eilean Siar" => [13, "Northern"],
		"Falkirk" => [14, "Central"],
		"Fife" => [15, "Fife"],
		"Glasgow City" => [16, "Strathclyde"],
		"Highland" => [17, "Northern"],
		"Inverclyde" => [18, "Strathclyde"],
		"Midlothian" => [19, "Strathclyde"],
		"Moray" => [20, "Grampian"],
		"North Ayrshire" => [21, "Strathclyde"],
		"North Lanarkshire" => [22, "Strathclyde"],
		"Orkney Islands" => [23, "Northern"],
		"Perth & Kinross" => [24, "Tayside"],
		"Renfrewshire" => [25, "Strathclyde"],
		"Scottish Borders" => [26, "Lothian & Borders"],
		"Shetland Islands" => [27, "Northern"],
		"South Ayrshire" => [28, "Strathclyde"],
		"South Lanarkshire" => [29, "Strathclyde"],
		"Stirling" => [30, "Central"],
		"West Dunbartonshire" => [31, "Strathclyde"],
		"West Lothian" => [32, "Lothian & Borders"]
	}
	
	regions.each do |key, value|
		region = Region.new
		region.id = value[0]
		region.police_region_id = PoliceRegion.find_by_name(value[1]).id
		region.name = key
		region.save
	end
  end
end
