class Category < BaseModel
  validates :name, uniqueness: true, presence: true
  has_many :pictures

  before_validation :set_handle

  def to_param
    handle
  end

  def top_image_url
    pictures.order(rating: :desc).first.url
  rescue
    #e.g. There are no images, Link 404 image
    "http://i.imgur.com/74FVTpV.jpg"
  end

  def random_image(count)
    pictures.offset(rand(count)).first
  end

  private

  def set_handle
    self.handle = name.parameterize
  end
end
