class Picture < ActiveRecord::Base
	before_create :default_values
	belongs_to :user

	#VALID_IMGUR_REGEX = /imgur.com/i
	validates :url, presence: true

	def default_values
		self.rating ||= 1500
	end
end
