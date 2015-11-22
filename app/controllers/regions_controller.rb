class RegionsController < ApplicationController
	def show
		respond_to do |format|
			format.html {
				@region_id = params[:id]
				@region = Region.find(@region_id)
				
				@police_region_id = @region.police_region_id
				@police_region = PoliceRegion.find(@police_region_id)
				
				@comments = Comment.where(:region_id => @region_id)
			}
			format.js {
				@region_id = params[:id]
				@region = Region.find(@region_id)
				
				@police_region_id = @region.police_region_id
				@police_region = PoliceRegion.find(@police_region_id)
				
				@crimes = Crime.where(:region_id => @region_id)
				@new_crimes = []
				
				@crimes.each do |crime|
					@crime_hash = {
						:year => crime.year,
						:region => Region.find(crime.region_id).name,
						:group => CrimeGroup.find(crime.group_id).name,
						:number => crime.number
					}
					@new_crimes.push(@crime_hash)
				end 
				@crimes = @new_crimes
				
				render json: @crimes
			}
		end
	end
end
