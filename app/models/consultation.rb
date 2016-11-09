class Consultation < ActiveRecord::Base
  belongs_to :patient
  default_scope -> { order('created_at DESC')}
  validates :patient_id, presence: true
end
