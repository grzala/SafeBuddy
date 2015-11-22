class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :region
	
	validates :message, length: {maximum: 300}
end
