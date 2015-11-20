require 'csv'

def upload_police_crimes
	path = "vendor/police_crime/"
	years = [2014, 2013, 2012, 2011, 2010, 2009]

	years.each do |year|
		file = path + year.to_s + ".csv"
		file = File.read(file)
		csv = CSV.parse(file, :headers => true)
		@region
		csv.each do |row|
			@r = row.to_hash
			@new_row = Hash.new
			@r.each do |key, value|
				if key == "Region"
					@region = value
					while(@region[-1] == " ")
						@region = @region.chop
					end
					while(@region[0] == " ")
						@region = @region.reverse.chop.reverse
					end
				else
				@crime = PoliceRegionCrime.new
				@crime.year = year
				year_string = year.to_s
				
				#delete whitespace
				while(key[-1] == " ")
					key = key.chop
				end
				while(key[0] == " ")
					key = key.reverse.chop.reverse
				end

				@crime.police_region_id = PoliceRegion.find_by_name(@region).id
				@crime.category_id = CrimeCategory.find_by_name(key).id
				@crime.number = value
			
				@crime.save
				end
			end
		end

	end
end

def upload_crimes
	path = "vendor/crime/"
	years = [2014, 2013, 2012, 2011, 2010, 2009]

	years.each do |year|
		file = path + year.to_s + ".csv"
		file = File.read(file)
		csv = CSV.parse(file, :headers => true)
		@region
		csv.each do |row|
			@r = row.to_hash
			@new_row = Hash.new
			@r.each do |key, value|
				if key == "Region"
					@region = value
					while(@region[-1] == " ")
						@region = @region.chop
					end
					while(@region[0] == " ")
						@region = @region.reverse.chop.reverse
					end
				else
				@crime = Crime.new
				@crime.year = year
				year_string = year.to_s
				
				#delete whitespace
				while(key[-1] == " ")
					key = key.chop
				end
				while(key[0] == " ")
					key = key.reverse.chop.reverse
				end
				
				@crime.region_id = Region.find_by_name(@region).id
				@crime.group_id = CrimeGroup.find_by_name(key).id
				@crime.number = value
			
				@crime.save	
				end
			end		
		end
	end
end
