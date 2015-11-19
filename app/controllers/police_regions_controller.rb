class PoliceRegionsController < ApplicationController
	def show
		respond_to do |format|
			format.html {
				@region_id = params[:id]
				@region = PoliceRegion.find(@region_id).name
				@police_crimes = PoliceRegionCrime.where(:police_region_id => @region_id)
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
			}
			format.js {
				@region_id = params[:id]
				@region = PoliceRegion.find(@region_id).name
				@police_crimes = PoliceRegionCrime.where(:police_region_id => @region_id)
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
				
				render json: @crimes
			}
		end
	end
end
