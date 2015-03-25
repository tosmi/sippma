class Setting < ActiveRecord::Base
  before_save { self.email = email.downcase }

  include SippmaRegex

  validates :title, length: { maximum: 20 }

  validates :firstname, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }
  validates :lastname, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }

  validates :city, length: { maximum: 50}
  validates :street, length: { maximum: 50}

  validates :phonenumber1, length: { maximum: 30}, format: { with: VALID_PHONENUMBER_REGEX }, :allow_blank => true
  validates :phonenumber2, length: { maximum: 30}, format: { with: VALID_PHONENUMBER_REGEX }, :allow_blank => true

  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, :allow_blank => true

  private_class_method :new, :create, :create!

  def Setting.instance
    first || create
  end

end
