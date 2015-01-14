class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  VALID_USERNAME_REGEX = /\A[a-zA-Z\d]+\z/
  validates :username, presence: true, length: { maximum: 20 }, format: { with: VALID_USERNAME_REGEX }, uniqueness: true

  VALID_FULLNAME_REGEX = /\A[a-z]+\s([a-z]+\s)*[a-z]+\z/i
  validates :fullname, presence: true, length: { maximum: 50 }, format: { with: VALID_FULLNAME_REGEX }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  validates :password, length: { minimum: 6 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine::cost
    BCrypt::Password.create(string, cost: cost)
  end

  has_secure_password
end
