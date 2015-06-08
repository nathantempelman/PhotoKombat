class Picture < ActiveRecord::Base
  include PicturesHelper
  before_create :default_values
  belongs_to :user
  belongs_to :category

  VALID_IMGUR_REGEX = /\A(?:https?:\/\/)?(?:www\.)?(?:i\.)?imgur\.com\/(?:gallery\/)?((?:\w|\d){7}|(?:\w|\d){5})(\w)?(?:\.(gif|jpg|png))?\z/i
  validates :url, presence: true
  validates :url, format: { with: VALID_IMGUR_REGEX, message: 'was not from Imgur' }

  def default_values
    self.rating ||= 1500
    self.url = imgur_format!(self.url)
  end

  def beats(loser)
    if self.id == loser.id
      return nil
    end

    Activity.register_activity(User.current_user, self, "photo combatted!", User.current_ip_address, { winning_image: self.url, losing_image: loser.url })

    ea = 1.0/(1.0+10**((loser.rating-self.rating)/400.0))
    self.rating  += 50.0*(1.0-ea)
    loser.rating -= 50.0*(1.0-ea)
    self.save
    loser.save
  end
#  	def expected_first_beats_second(first, second)
# 	1/(1+10**((second.rating-first.rating)/400))
# end
# def first_beat_second(picA,picB)
# 	ea = expected_first_beats_second(picA,picB)
# 	picA.rating += 50*(1-ea)
# 	picB.rating += 50*(-(1-ea))

# end
# def self.beat_by(picB)
# 	self.rating += 50*(-(expected_first_beats_second self picB))
# end
# def self.beat(picB)
# 	self.rating += 50*(1-(expected_first_beats_second self picB))
# end
end
