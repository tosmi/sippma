class Patient < ActiveRecord::Base
  before_save { self.email = email.downcase }

  VALID_NAME_REGEX = /\A[a-z]+\s([a-z]+\s)*[a-z]+\z/i
  validates :fristname, presence: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }
  validates :lastname, presence: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }

  VALID_ZIP_REGEX = /\A\d{4}\z/
  validates :zip, presence: true, length: { maximum: 50}, format: { with: VALID_ZIP_REGEX }

  validates :city, presence: true, length: { maximum: 50}
  validates :street, presence: true, length: { maximum: 50}

  VALID_PHONENUMBER_REGEX = //
  validates :phonenumber1, presence: true, length: { maximum: 50}, format: { with: VALID_PHONENUMBER_REGEX }
  validates :phonenumber2, presence: true, length: { maximum: 50}, format: { with: VALID_PHONENUMBER_REGEX }
  validates :insurance, presence: true, length: { maximum: 50}

  VALID_SSN_REGEX = //
  validates :ssn, presence: true, length: { maximum: 50}, format: { with: VALID_SSN_REGEX }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

end
