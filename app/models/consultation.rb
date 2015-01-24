class Consultation < ActiveRecord::Base
  belongs_to :patient
  validates :patient_id, presence: true
  validates :diagnosis, presence: true, length: { maximum: 200 }
end
