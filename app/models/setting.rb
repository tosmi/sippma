class Setting < ActiveRecord::Base
  before_save { self.email = email.downcase }

  include SippmaRegex

  validates :firstname, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }
  validates :lastname, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }
end
