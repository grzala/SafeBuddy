class CreateCrimeCategories < ActiveRecord::Migration
  def change
    create_table :crime_categories do |t|
      t.string :name
      t.integer :group_id

      t.timestamps null: false
    end
    
    
	categories = {
		1 => ["Homicide", "Serious assault & attempted murder", "Robbery", "Other violence"],
		2 => ["Rape & attempted rape", "Sexual assault", "Offences associated with prostitution", "Other sexual"],
		3 => ["Housebreaking", "Theft by opening a lockfast place", "Theft from a motor vehicle", "Theft of a motor vehicle", "Shoplifting", "Other theft", "Fraud", "Other dishonesty"],
		4 => ["Fire-raising", "Vandalism etc."],
		5 => ["Crimes against public justice", "Handling an offensive weapon", "Drugs", "Other other"],
		6 => ["Common assault", "Breach of the peace etc.", "Drunkenness", "Other misc"],
		7 => ["Dangerous and careless driving", "Driving under the influence", "Speeding", "Unlawful use of vehicle", "Vehicle defect offences", "Other vehicle"]
    }
	
	categories.each do |id, names|
		names.each do |name|
			category = CrimeCategory.new
			category.name = name
			category.group_id = id
			category.save
		end
    end
    
  end
end
