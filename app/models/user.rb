class User < ActiveRecord::Base
  has_one :account, dependent: :destroy
  has_many :capitals, dependent: :destroy
  before_save {self.email = self.email.downcase}
  before_create :create_remember_token

  mount_uploader :image, ImageUploader
  validates :name, presence: true, length: { maximum: 50}
  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6}
  has_secure_password


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # Returns true if the given token matches the digest
  def authenticate?(attribute, key)
    if attribute.include key
      return true
    else
      return false
    end
  end

	def invalidate_auth_token
		self.update_columns(auth_token: nil)
	end

	def self.valid_login?(email, password)
		user = find_by(email: email)
		if user && user.authenticate(password)
			user
		end
	end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

	def generate_auth_token
		loop do
			self.auth_token = SecureRandom.base64(64)
			break unless User.find_by(auth_token: auth_token)
		end
	end

  private
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

    def create_activation_digest
      self.activation_digest = User.digest(User.new_remember_token)
    end
end
