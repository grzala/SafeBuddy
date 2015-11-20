class PoliceRegionsController < ApplicationController
	def index
		@regions = PoliceRegion.all
	end
	def show
		respond_to do |format|
			format.html {
			}
			format.js {
				@region_id = params[:id]
				if @region_id == "all"
					@police_crimes = PoliceRegionCrime.all
				else
					@region = PoliceRegion.find(@region_id).name
					@police_crimes = PoliceRegionCrime.where(:police_region_id => @region_id)
				end
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
