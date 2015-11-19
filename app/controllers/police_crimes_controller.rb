class PoliceCrimesController < ApplicationController
  def list
	@police_crimes = PoliceRegionCrime.all
	@crimes = []
	
	@police_crimes.each do |crime|
		@crime_hash = {
			:year => crime.year,
			:region => PoliceRegion.find(crime.police_region_id).name,
			:category => CrimeCategory.find(crime.category_id).name,
			:group => CrimeGroup.find(CrimeCategory.find(crime.category_id).group_id).name,
			:number => crime.number
		}
		@crimes.push(@crime_hash)
	end
  end
end
