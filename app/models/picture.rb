class Picture < ActiveRecord::Base
	include PicturesHelper
	before_create :default_values
	belongs_to :user

	VALID_IMGUR_REGEX = /\A(?:https?:\/\/)?(?:www\.)?(?:i\.)?imgur\.com\/((?:\w|\d){7})(\w)?(?:\.(gif|jpg|png))?\z/i
	validates :url, presence: true, format: { with: VALID_IMGUR_REGEX }

	def default_values
		self.rating ||= 1500

		self.url = imgur_format!(self.url)
	end
end
