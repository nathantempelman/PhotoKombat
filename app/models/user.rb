class User < BaseModel
	before_create :create_remember_token
	has_many :pictures
  has_many :activities, as: :owner

	validates :username, presence: true, length: {minimum: 3, maximum: 22}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
	validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX}, if: :email?
	has_secure_password
	validates :password, length: {minimum: 6}, if: :changed_password?

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

   def changed_password?
    password.present? && self.password_digest_changed?
  end

  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end

    def current_ip_address=(ip)
      Thread.current[:current_ip_address] = ip
    end

    def current_ip_address
      Thread.current[:current_ip_address]
    end
  end

end
