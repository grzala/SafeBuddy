require 'csv'

def upload_police_crimes
	path = "vendor/police_crime/"
	years = [2014]

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
				else
				@crime = PoliceRegionCrime.new
				@crime.year = year
				year_string = year.to_s
				
				#delete whitespace
				while(key[-1] == " ")
					key = key.chop
				end
				
				puts "category: "+key+" number: "+value.to_s+" year: "+year_string+" region: "+@region

				@crime.police_region_id = PoliceRegion.find_by_name(@region).id
				@crime.category_id = CrimeCategory.find_by_name(key).id
				@crime.number = value
			
				@crime.save
				end
			end
			puts "\n\n"
		end

	end
end
