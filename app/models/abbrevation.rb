class Abbrevation < ActiveRecord::Base
  validates :abbrev, presence: true, length: { maximum: 4 }
  validates :text, presence: true, length: { maximum: 255 }
end
