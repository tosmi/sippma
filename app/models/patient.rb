class Patient < ActiveRecord::Base
  has_many :consultations
  has_many :receipts

  include SippmaRegex
  default_scope { order('lastname DESC') }

  before_save { self.email = email.downcase }

  VALID_NAME_REGEX = /\A[a-zA-Z]+\s?([a-zA-Z]+\s)*[a-zA-Z]+\z/i
  validates :firstname, presence: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }
  validates :lastname, presence: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }

  VALID_ZIP_REGEX = /\A\d{1,5}\z/
  validates :zip, presence: true, length: { maximum: 5}, format: { with: VALID_ZIP_REGEX }

  validates :city, presence: true, length: { maximum: 50}
  validates :street, presence: true, length: { maximum: 50}

  VALID_PHONENUMBER_REGEX = /\A\+?\d+([-\s\/]?\d+)*\d\z/
  validates :phonenumber1, length: { maximum: 30}, format: { with: VALID_PHONENUMBER_REGEX }, :allow_blank => true
  validates :phonenumber2, length: { maximum: 30}, format: { with: VALID_PHONENUMBER_REGEX }, :allow_blank => true

  validates :insurance, presence: true, length: { maximum: 50}, format: { with: VALID_NAME_REGEX }

  VALID_SSN_REGEX = /\A\d{1,5}\z/
  validates :ssn, presence: true, length: { maximum: 5}, format: { with: VALID_SSN_REGEX }

  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, :allow_blank => true

  validates :birthdate, presence: true

end
