class User < ActiveRecord::Base
  validates :fullname, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
end
